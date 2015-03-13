//
//  ByThisTimeController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 13/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit
import AVFoundation

class ByThisTimeVController: UIViewController {
    
    var timeCounter: NSTimer = NSTimer()
    var waitTime: NSTimeInterval = NSTimeInterval()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       //self.view.backgroundColor = UIColor.blueColor()
        timeCounter = NSTimer.scheduledTimerWithTimeInterval(waitTime, target: self, selector: Selector("waitIsOver"), userInfo: nil, repeats: true)
        
        println("WaitTime: \(waitTime)")
        
    }
    
    @IBAction func backButtonPressed(sender: UIButton)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func waitIsOver()
    {
        println("TheWaitIsOver")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) //vibrates the phone
    }
    
}
