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
    
    
    
    @IBAction func backMenu(sender: UIButton)
    {
        feedBackTimer.invalidate() // Stops Timer Loop when leaves this Screen
        self.dismissViewControllerAnimated(false, completion: nil)
    
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        feedBackTimer = NSTimer.scheduledTimerWithTimeInterval(feedBackInterval, target:self, selector: Selector("startAlarm"),userInfo:nil, repeats: false)
        
    }
    
    func startAlarm()
    {
        NSLog("timer started")
         feedBackTimer = NSTimer.scheduledTimerWithTimeInterval(waitingFeedBackInterval, target:self, selector: Selector("getFeedBack"),userInfo:nil, repeats: true)
    }
    
    
    func getFeedBack()
    {

        feedBackCounter++
        NSLog("Wake up! Don't fall asleep!! (\(feedBackCounter))")
        
        if (vibrate == true)
        {
            NSLog("vibrando")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))  // roda varias vezes no loop de acordar
        }
        
        if ( feedBackCounter == 1 )  // roda só uma vez no loop de acordar
        {
            if (sound == true)
            {
                player.play()
            }
            var numeroFeedBackEscolhido: Int = Int(arc4random_uniform(UInt32(feedBackTypeArray.count)))  // escolhe um feedback aleatorio entre os escolhidos anteriormente
            var feedBackEscolhido: String = feedBackTypeArray[numeroFeedBackEscolhido] as String
        
            NSLog("\(feedBackEscolhido)")
        
            if (feedBackEscolhido == "tap")
            {
                var tapTheScreenLabel: UILabel = UILabel(frame: CGRectMake(self.view.frame.width/3, self.view.frame.height/2, 100, 50))
                tapTheScreenLabel.text = "Tap me!!"
        
                view.addSubview(tapTheScreenLabel)
        
                var tapFeedBack = UITapGestureRecognizer(target: self, action: Selector("didGetFeedBack:"))
                view.addGestureRecognizer(tapFeedBack)
                
            }
            else if (feedBackEscolhido == "slide")
            {
                var slideTheScreenLabel: UILabel = UILabel(frame: CGRectMake(self.view.frame.width/3, self.view.frame.height/2, 100, 50))
                slideTheScreenLabel.text = "Slide here!"
            
                view.addSubview(slideTheScreenLabel)
            
                var slideFeedBack = UIPanGestureRecognizer(target: self, action: Selector("didGetFeedBack:"))
                view.addGestureRecognizer(slideFeedBack)

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
