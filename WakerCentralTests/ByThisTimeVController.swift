//
//  ByThisTimeController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 13/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit
import AVFoundation

//Class Control Time and Vibrations

class ByThisTimeVController: UIViewController {
    
    private var timeCounter: NSTimer = NSTimer()
    private var waitTime: NSTimeInterval = NSTimeInterval()
    private var player:AVAudioPlayer = AVAudioPlayer();
    private var vibrate: Bool = true
    private var sound: Bool = false

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        backButton.enabled=false
        let startButton   = UIButton()
        startButton.setImage(UIImage(named: "startButton"), forState: .Normal)
        startButton.frame = CGRectMake(0, 0, 200, 200)
        startButton.center = CGPointMake(self.view.frame.width/3, self.view.frame.height + 20)
        startButton.setTitle("Start", forState: .Normal)
        startButton.addTarget(self, action: "startbuttonAction:", forControlEvents: UIControlEvents.TouchUpInside)

        let whereToButton   = UIButton()
        whereToButton.setImage(UIImage(named: "sideButton.jpg"), forState: .Normal)
        whereToButton.setTitle("Where To?", forState: .Normal)
//        whereToButton.titleLabel?.text = "Where To?"
        whereToButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    
        whereToButton.frame = CGRectMake(0, self.view.frame.height - 50, 200, 200)
        //whereToButton.addTarget(self, action: "whereTobuttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(whereToButton)
        self.view.addSubview(startButton)

    
        timeCounter = NSTimer.scheduledTimerWithTimeInterval(waitTime, target: self, selector: Selector("waitIsOver"), userInfo: nil, repeats: true)
        
        println("WaitTime: \(waitTime)")
        
    }

    
    
    @IBAction func startButtonPressed(sender: UIButton)
    {
        
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton)
    {
        
        timeCounter.invalidate()
        if(sound==true)
        {
            player.stop()
        }
        
        self.stopButton.enabled=false;
        self.backButton.enabled=true;
    }
    @IBAction func backButtonPressed(sender: UIButton)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    //What happens when time cancels
    func waitIsOver()
    {
        stopButton.enabled=true;
        backButton.enabled=false
        
        println("TheWaitIsOver v:\(vibrate) s:\(sound)" )
        if(vibrate==true)
        {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) //vibrates the phone
        }
        if(sound==true)
        {
            player.play();
            
        }
        
    }
    func setSoundToPlay(soundName:String, ofType:String, timeToWait: NSTimeInterval)
    {
        waitTime=timeToWait
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: ofType)!)
        var error:NSError?
        player = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        player.prepareToPlay()
        sound=true
        vibrate=false
        
    }
    func setToVibrate(timeToWait: NSTimeInterval)
    {
        println("Set sound ")
        waitTime=timeToWait
        sound=false
        vibrate=true
        
    }
    func setToVibrateAndToPlaySound(soundName:String, ofType:String, timeToWait: NSTimeInterval)
    {
        waitTime=timeToWait
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: ofType)!)
        var error:NSError?
        player = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        player.prepareToPlay()
        sound=true
        vibrate=true
        
        
}
}