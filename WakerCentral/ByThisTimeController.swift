//
//  ByThisTimeController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 13/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit
import AVFoundation

class ByThisTimeController: UIViewController {
    
    private var timeCounter: NSTimer = NSTimer()
    private var waitTime: NSTimeInterval = NSTimeInterval()
    private var player:AVAudioPlayer = AVAudioPlayer();
    private var vibrate: Bool = true
    private var sound: Bool = false
    
    
    
    

    
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        timeCounter = NSTimer.scheduledTimerWithTimeInterval(waitTime, target: self, selector: Selector("waitIsOver"), userInfo: nil, repeats: true)
        stopButton.enabled=false;
        
      
        
        println("WaitTime: \(waitTime)")
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func waitIsOver()
    {
        stopButton.enabled=true;
        
        
        println("TheWaitIsOver")
        if(vibrate==true)
        {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) //vibrates the phone
        }
        if(sound==true)
        {
            player.play();
            
        }
        
    }
    
    @IBAction func StopButtonPressed(sender: UIButton)
    {
        timeCounter.invalidate()
        player.stop()
        self.stopButton.enabled=false;
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
