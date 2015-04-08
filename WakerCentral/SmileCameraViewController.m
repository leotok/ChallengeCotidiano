//
//  SmileImageViewController.m
//  SmileCameraViewControllerDemo
//
//  Created by maxim.makhun on 5/9/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssertMacros.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Social/Social.h>

#import "SmileCameraViewController.h"



@interface SmileCameraViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UILabel *counterLabel;


@end

CGFloat degreesToRadians(CGFloat degrees)
{
    
    return degrees * M_PI / 180;
};

@interface UIImage (Rotate)

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage (Rotate)

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

static const NSString *AVCaptureStillImageIsCapturingStillImageContext = @"AVCaptureStillImageIsCapturingStillImageContext";

@interface SmileCameraViewController (InternalMethods)


- (void)setupAVCapture;
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;

@end

@implementation SmileCameraViewController

int smileCountdown = 0;


- (void)setupAVCapture
{
	NSError *error = nil;
	
	AVCaptureSession *session = [AVCaptureSession new];
    [session setSessionPreset:AVCaptureSessionPreset640x480];
    
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
	
	if ([session canAddInput:deviceInput])
    {
        [session addInput:deviceInput];
    }
    
	mStillImageOutput = [AVCaptureStillImageOutput new];
	[mStillImageOutput addObserver:self forKeyPath:@"capturingStillImage" options:NSKeyValueObservingOptionNew context:(__bridge void *)(AVCaptureStillImageIsCapturingStillImageContext)];
	if ([session canAddOutput:mStillImageOutput])
    {
        [session addOutput:mStillImageOutput];
    }
    
	mVideoDataOutput = [AVCaptureVideoDataOutput new];
	
	NSDictionary *rgbOutputSettings = [NSDictionary dictionaryWithObject:
									   [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
	[mVideoDataOutput setVideoSettings:rgbOutputSettings];
	[mVideoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    
	mVideoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
	[mVideoDataOutput setSampleBufferDelegate:self queue:mVideoDataOutputQueue];
	
    if ([session canAddOutput:mVideoDataOutput])
    {
        [session addOutput:mVideoDataOutput];
    }
    
	[[mVideoDataOutput connectionWithMediaType:AVMediaTypeVideo] setEnabled:NO];
	
	mPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
	[mPreviewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
	[mPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	CALayer *rootLayer = [previewView layer];
	[rootLayer setMasksToBounds:YES];
	[mPreviewLayer setFrame:[rootLayer bounds]];
	[rootLayer addSublayer:mPreviewLayer];
	[session startRunning];
    
bail:
    
	if (error)
    {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Failed with error %d", (int)[error code]]
															message:[error localizedDescription]
														   delegate:nil
												  cancelButtonTitle:@"Dismiss"
												  otherButtonTitles:nil];
		[alertView show];
	}
    
    AVCaptureDevicePosition desiredPosition = AVCaptureDevicePositionFront;
	
	for (AVCaptureDevice *captureDevice in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo])
    {
		if ([captureDevice position] == desiredPosition)
        {
			[[mPreviewLayer session] beginConfiguration];
			AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
			
            for (AVCaptureInput *oldInput in [[mPreviewLayer session] inputs])
            {
				[[mPreviewLayer session] removeInput:oldInput];
			}
            
			[[mPreviewLayer session] addInput:input];
			[[mPreviewLayer session] commitConfiguration];
			break;
		}
	}
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//Essa Função é chamada pelo performSelector
-(void) updateTextLabel
{
    self.counterLabel.text=[NSString stringWithFormat:@"%d",smileCountdown];
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
	CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
	CIImage *ciImage = [[CIImage alloc] initWithCVPixelBuffer:pixelBuffer options:(__bridge NSDictionary *)attachments];
	if (attachments)
    {
        CFRelease(attachments);
    }
    
	NSDictionary *imageOptions = nil;
    
	imageOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:6], CIDetectorImageOrientation, [NSNumber numberWithBool:YES], CIDetectorSmile, nil];
    
	NSArray *features = [mFaceDetector featuresInImage:ciImage options:imageOptions];

    
    for (CIFaceFeature* faceFeature in features)
    {
        if (faceFeature.hasSmile)
        {
            NSLog(@"SmileCountDown %d SmileCountDownText %@",smileCountdown,self.counterLabel.text);
            smileCountdown++;
            //[self.counterLabel removeFromSuperview];
            //[self.view addSubview:self.counterLabel];
            [self performSelectorOnMainThread:@selector(updateTextLabel) withObject:self waitUntilDone:YES]; //Manda  chamar a função antes de continuar o código nesse escopo
           // [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
            
            if (smileCountdown > 5)
            {
                smileCountdown = 0;
                
                dispatch_async(dispatch_get_main_queue(), ^(void)
                               {
                                   UIImage *image = [[UIImage alloc] initWithCIImage:ciImage];
                                   mTakenPhoto = image;
                               });
                [[mPreviewLayer session] stopRunning];
                [mStillImageOutput removeObserver:self forKeyPath:@"capturingStillImage" context:(__bridge void *)(AVCaptureStillImageIsCapturingStillImageContext)];
                

                NSLog(@"Should Cancell Alarm");
                
               
                //[self removeFromParentViewController];
                [self dismissViewControllerAnimated:NO completion: ^{
                    
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"userSmiled" object:nil];  //Sends Message "UserSmiled" to receiver in the swift code.
                
                }];
                
            }
        }
        else
        {
            NSLog(@"%d",smileCountdown);
            smileCountdown = 0;
            //[self.counterLabel setText:[NSString stringWithFormat:@"%d",smileCountdown]];
            [self performSelectorOnMainThread:@selector(updateTextLabel) withObject:self waitUntilDone:YES]; //Manda  chamar a função antes de continuar o código nesse escopo

            
            
        }
            break;
        
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupAVCapture];
    
    
	NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyHigh, CIDetectorAccuracy, nil];
	mFaceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
}


- (IBAction)retakePhotoButtonPressed:(id)sender
{
    if (![[mPreviewLayer session] isRunning])
    {
        [[mPreviewLayer session] startRunning];
    }
}


- (UIImage *)resizeImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
