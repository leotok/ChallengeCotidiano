//
//  SetModeVController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 17/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit

class SetModeVController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var vibrateSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var soundPicker: UIPickerView!
    @IBOutlet weak var tapSwitch: UISwitch!
    @IBOutlet weak var slideSwitch: UISwitch!
  
    @IBOutlet weak var timePicker: UIDatePicker!
    var soundName: String = String("")
    var soundFormat: String = String("mp3")
    
    var soundArray: [String] = ["alarm_classic","alarm_sound","alarm"]
    
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Default
        
        vibrateSwitch.on=true
        soundSwitch.on=false
        
        if(soundSwitch.on==false)
        {
            soundPicker.hidden=true
        }
        
        tapSwitch.on=true
        slideSwitch.on=false
        soundPicker.delegate=self
        
        
        
        // Do any additional setup after loading the view.
    }


    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = soundArray[row]
        
        return label    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonPressed(sender: UIButton) {
        let vc = ByThisTimeVController(nibName: "ByThisTimeVController", bundle: nil)
        
        
        var timeToWait: NSTimeInterval = timePicker.countDownDuration
        println("on \(vibrateSwitch.on) \(soundSwitch.on)")
        if(vibrateSwitch.on==true)
        {
            if(soundSwitch.on==true)
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
            if(soundSwitch.on==true)
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

    @IBAction func soundSwitchChanged(sender: UISwitch) {
       soundPicker.hidden = !sender.on
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
