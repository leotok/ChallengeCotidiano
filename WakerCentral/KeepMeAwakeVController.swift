////
//  KeepMeAwakeVController.swift
//  WakerCentral
//
//  Created by Leonardo Edelman Wajnsztok on 17/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit
import AVFoundation

class KeepMeAwakeVController: UIViewController {

    private var player: AVAudioPlayer = AVAudioPlayer()
    private var vibrate: Bool = true
    private var sound: Bool = false
    private var feedBackTypeDic: NSMutableDictionary = NSMutableDictionary()
    private var feedBackTypeArray: NSMutableArray = NSMutableArray()
    private var feedBackTimer: NSTimer = NSTimer()
    private var feedBackInterval: NSTimeInterval = NSTimeInterval()
    private var waitingFeedBackInterval: NSTimeInterval = NSTimeInterval(2);
    private var feedBackCounter: Int = 0
    
    
    
    @IBAction func backMenu(sender: UIButton) {
        self.dismissViewControllerAnimated(false, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let startButton   = UIButton()
        startButton.setImage(UIImage(named: "startButton"), forState: .Normal)
        startButton.frame = CGRectMake(0, 0, 200, 200)
        startButton.center = CGPointMake(self.view.frame.width/3.2, self.view.frame.height + 20)
        startButton.setTitle("Start", forState: .Normal)
       // startButton.addTarget(self, action: "startbuttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let wakeModeButton   = UIButton()
        wakeModeButton.setImage(UIImage(named: "sideButton.jpg"), forState: .Normal)
        //wakeModeButton.setTitle("Where To?", forState: .Normal)
        wakeModeButton.frame = CGRectMake(0, self.view.frame.height - 50, 200, 200)
        //wakeModeButton.addTarget(self, action: "whereTobuttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        

        let cafezinConfigButton   = UIButton()
        cafezinConfigButton.setImage(UIImage(named: "sideButton.jpg"), forState: .Normal)
       // cafezinConfigButton.setTitle("Where To?", forState: .Normal)
        cafezinConfigButton.frame = CGRectMake(self.view.frame.width/3, self.view.frame.height - 50, 200, 200)
        //cafezinConfigButton.addTarget(self, action: "whereTobuttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(wakeModeButton)
        self.view.addSubview(cafezinConfigButton)
        self.view.addSubview(startButton)
        
       
        feedBackTimer = NSTimer.scheduledTimerWithTimeInterval(feedBackInterval, target:self, selector: Selector("startAlarm"),userInfo:nil, repeats: false)
        
    }
    
    func startAlarm()
    {
        
         feedBackTimer = NSTimer.scheduledTimerWithTimeInterval(waitingFeedBackInterval, target:self, selector: Selector("getFeedBack"),userInfo:nil, repeats: true)
    }
    
    
    func getFeedBack()
    {
//       feedBackTimer.invalidate()
        feedBackCounter++
        
        var numeroFeedBackEscolhido: Int = Int(arc4random_uniform(UInt32(feedBackTypeArray.count)))
        
        NSLog("Wake up! Don't fall asleep!!")
        
        if (vibrate == true)
        {
            NSLog("vibrando")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        if (sound == true)
        {
            player.play()
        }
        
        var feedBackEscolhido: String = feedBackTypeArray[numeroFeedBackEscolhido] as String
        
        NSLog("\(feedBackEscolhido)")
        
        if (feedBackEscolhido == "tap")
        {
            var tapTheScreenLabel: UILabel = UILabel(frame: CGRectMake(self.view.frame.width/3, self.view.frame.height/2, 100, 50))
            tapTheScreenLabel.text = "Tap me!!"
        
            self.view.addSubview(tapTheScreenLabel)
            
            if (feedBackCounter == 1)
            {
                var tapFeedBack = UITapGestureRecognizer(target: self, action: Selector("didGetFeedBack:"))
                view.addGestureRecognizer(tapFeedBack)
            }
        }
    }
    
    
    func didGetFeedBack (gesture: UIGestureRecognizer)
    {
        feedBackTimer.invalidate()
        feedBackCounter = 0
        
        if(sound == true)
        {
            player.stop()
        }
        NSLog("Tapped")
        view.removeGestureRecognizer(gesture)
        
        feedBackTimer = NSTimer.scheduledTimerWithTimeInterval(feedBackInterval, target:self, selector: Selector("startAlarm"),userInfo:nil, repeats: false)
        
    }
    
    func setFeedBackTypesAndTimeInterval(fbTypes: NSMutableDictionary, timeInterval: NSTimeInterval)
    {
        
        self.feedBackTypeDic = fbTypes
        feedBackInterval = timeInterval
        
        if(feedBackTypeDic.objectForKey("tap") as String ==  "1")
        {
            feedBackTypeArray.addObject("tap")
        }
        if(feedBackTypeDic.objectForKey("slide") as String == "1")
        {
            feedBackTypeArray.addObject("slide")
        }
        if(feedBackTypeDic.objectForKey("wink")as String == "1")
        {
            feedBackTypeArray.addObject("wink")
        }
        if(feedBackTypeDic.objectForKey("smile")as String == "1")
        {
            feedBackTypeArray.addObject("smile")
        }
        
    }
    
    func setToVibrateAndToPlaySound(soundName:String, ofType:String)
    {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: ofType)!)
        var error:NSError?
        player = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        player.prepareToPlay()
        sound=true
        vibrate=true
        
    }

    func setSoundToPlay(soundName:String, ofType: String)
    {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: ofType)!)
        var error: NSError?
        player = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        player.prepareToPlay()
        
        sound = true
        vibrate = false
    }
   
    
    func setToVibrate()
    {
        sound = false
        vibrate = true
    }

}
