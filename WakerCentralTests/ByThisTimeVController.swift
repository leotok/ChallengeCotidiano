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
    private var timerUpdate: NSTimeInterval = NSTimeInterval(1)
    private var timeNow:NSTimeInterval = NSTimeInterval(0)
   
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        backButton.enabled=false    
        
        timeCounter = NSTimer.scheduledTimerWithTimeInterval(timerUpdate, target: self, selector: Selector("timeUpdate"), userInfo: nil, repeats: true)
        
        countDownLabel.text=getTimerString()
        
        println("WaitTime: \(waitTime)")
        
        
    }

    private func getTimerString() ->String
    {
        var mins: Int;
        var secs: Int;
        var hours: Int;
        var result:String;
        
        var c : Int
        
        
        
        
        
        var time:NSTimeInterval = waitTime - timeNow
        
        hours = Int(time/3600)
        mins = Int(time/60) - hours*60
        secs = Int(time) - mins*60 - hours*3600
        
//        var dateFormat: NSDateFormatter = NSDateFormatter()
//        dateFormat.setLocalizedDateFormatFromTemplate("hh:mm:ss")
//        var date: NSDate = NSDate(timeIntervalSince1970: time)
//        result = dateFormat.stringFromDate(date)
        var hS: String = "%d";
        var sS: String = "%d";
        var mS: String = "%d";
        
        if(secs<10)
        {
            sS="0%d"
        }
        if(mins<10)
        {
            mS="0%d"
        }
        if(hours<10)
        {
            hS="0%d"
        }
        var formatS: String = hS + ":" + mS + ":" + sS
        
        result = String(format: formatS, hours,mins,secs)
        
        return result;
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
    func timeUpdate()
    {
        timeNow += timerUpdate
        
        if(timeNow > waitTime)
        {
            self.waitIsOver();
        }
        else
        {
            countDownLabel.text = getTimerString()
        }
        
    }
    
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