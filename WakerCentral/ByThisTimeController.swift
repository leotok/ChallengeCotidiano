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
    
    var timeCounter: NSTimer = NSTimer()
    var waitTime: NSTimeInterval = NSTimeInterval()

    override func viewDidLoad() {
        super.viewDidLoad()
        timeCounter = NSTimer.scheduledTimerWithTimeInterval(waitTime, target: self, selector: Selector("waitIsOver"), userInfo: nil, repeats: true)
        
        println("WaitTime: \(waitTime)")
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func waitIsOver()
    {
        println("TheWaitIsOver")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) //vibrates the phone
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
