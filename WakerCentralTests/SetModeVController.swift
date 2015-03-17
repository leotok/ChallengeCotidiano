//
//  SetModeVController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 17/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit

class SetModeVController: UIViewController {

    @IBOutlet weak var vibrateSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var soundPicker: UIPickerView!
    @IBOutlet weak var tapSwitch: UISwitch!
    @IBOutlet weak var slideSwitch: UISwitch!
  
    @IBOutlet weak var timePicker: UIDatePicker!
    var soundName: String = String("")
    var soundFormat: String = String("mp3")
    
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Default
        
        vibrateSwitch.selected=true
        soundSwitch.selected=false
        
        if(soundSwitch.selected==false)
        {
            soundPicker.hidden=true
        }
        
        tapSwitch.selected=true
        slideSwitch.selected=false
        
        
        
        
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonPressed(sender: UIButton) {
        let vc = ByThisTimeVController(nibName: "ByThisTimeVController", bundle: nil)
        
        var timeToWait: NSTimeInterval = 1
        if(vibrateSwitch.selected==true)
        {
            if(soundSwitch.selected==true)
            {
                vc.setToVibrateAndToPlaySound("alarm_sound", ofType: ".mp3", timeToWait: timeToWait)
            }
            else
            {
                vc.setToVibrate(timeToWait)
            }
        }
        else
        {
            if(soundSwitch.selected==true)
            {
                vc.setSoundToPlay("alarm_sound", ofType: ".mp3", timeToWait: timeToWait)
            }
            else
            {
                println("ERROR");
                return
            }
        }
        
        self.presentViewController(vc, animated: false, completion: nil)
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
