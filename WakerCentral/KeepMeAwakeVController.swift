//
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
    private var feedBackTimer: NSTimer = NSTimer()
    private var feedBackInterval: NSTimeInterval = NSTimeInterval()
    
    
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
        

        //feedBackInterval =
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
