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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       //self.view.backgroundColor = UIColor.blueColor()
        timeCounter = NSTimer.scheduledTimerWithTimeInterval(waitTime, target: self, selector: Selector("waitIsOver"), userInfo: nil, repeats: true)
        
        println("WaitTime: \(waitTime)")
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton)
    {
        timeCounter.invalidate()
        if(sound==true)
        {
            player.stop()
        }
        
        self.stopButton.enabled=false;
    }
    @IBAction func backButtonPressed(sender: UIButton)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    //What happens when time cancels
    func waitIsOver()
    {
        stopButton.enabled=true;
        
        
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

    
