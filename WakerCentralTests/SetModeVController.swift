//
//  SetModeVController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 17/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit

class SetModeVController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    enum viewControllers
    {
        case KeepMeAwakeVController
    
        case ByThisTimeVController
        
        case NearLocationVController
    }
    
    var vcToPresent: viewControllers = viewControllers.ByThisTimeVController
    
    var backgroundImage: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
    var leftButton: UIButton = UIButton(frame: CGRectMake(0,UIScreen.mainScreen().bounds.height / 1.16 , 342/1.8, 151/1.8))
    var rightButton: UIButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width/2,UIScreen.mainScreen().bounds.height / 1.16 , 292/1.8  ,  151/1.8))
    var okButton: UIButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width/3,UIScreen.mainScreen().bounds.height / 1.2 , 198/1.8 , 176/1.8))
    var backButton: UIButton = UIButton(frame: CGRectMake(10,20 , 30 , 30))
    
    var vibrateSwitch: UISwitch = UISwitch(frame: CGRectMake(200, 100, 40, 30))
    var soundSwitch: UISwitch = UISwitch(frame: CGRectMake(200, 150, 40, 30))
    var tapSwitch: UISwitch = UISwitch(frame: CGRectMake(200, 200, 40, 30))
    var slideSwitch: UISwitch  = UISwitch(frame: CGRectMake(200, 250, 40, 30))

    var vibrateLabel: UILabel = UILabel(frame: CGRectMake(100, 100, 70, 30))
    var soundLabel: UILabel = UILabel(frame: CGRectMake(100, 150, 70, 30))
    var tapLabel: UILabel = UILabel(frame: CGRectMake(100, 200, 70, 30))
    var slideLabel: UILabel = UILabel(frame: CGRectMake(100, 250, 70, 30))
    
    
    var soundPicker: UIPickerView = UIPickerView(frame: CGRectMake(60, 290, 200, 162.0))
    var timePicker: UIDatePicker = UIDatePicker()
    var soundName: String = String("")
    var soundFormat: String = String("mp3")
    
    var soundArray: [String] = ["alarm_classic","alarm_sound","alarm"]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Default
        
        backgroundImage.image = UIImage(named: "configbg.png")
        
        // buttons
        
        leftButton.setImage(UIImage(named: "wheretogo"), forState: UIControlState.Normal)
        rightButton.setImage(UIImage(named: "wakemode"), forState: UIControlState.Normal)
        okButton.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        okButton.addTarget(self, action: Selector("okButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setImage(UIImage(named: "backbt"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: Selector("backMenu2:"), forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.addTarget(self, action: Selector("leftRightButtons:"), forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.tag = 0
        rightButton.addTarget(self, action: Selector("leftRightButtons:"), forControlEvents: UIControlEvents.TouchUpInside)
        rightButton.tag = 1
        
        soundSwitch.addTarget(self, action: Selector("soundSwitchChanged:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        // labels
        
        vibrateLabel.text = "Vibrate"
        soundLabel.text = "Sound"
        tapLabel.text = "Tap"
        slideLabel.text = "Slide"
        
        // pickers
        
        timePicker.frame = CGRectMake(60, 290, 200, 162.0)
        timePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
        
        // adiciona os elementos na tela
        
        view.addSubview(backgroundImage)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(okButton)
        view.addSubview(backButton)
        
        view.addSubview(vibrateSwitch)
        view.addSubview(soundSwitch)
        view.addSubview(tapSwitch)
        view.addSubview(slideSwitch)
        
        view.addSubview(vibrateLabel)
        view.addSubview(soundLabel)
        view.addSubview(tapLabel)
        view.addSubview(slideLabel)
        
        view.addSubview(soundPicker)
        
       
        
        // seta os elementos na config default
        
        vibrateSwitch.on=true
        soundSwitch.on=false
        tapSwitch.on=true
        slideSwitch.on=false
        soundPicker.delegate=self
        
        if(soundSwitch.on==false)
        {
            soundPicker.hidden=true
        }
        
        
        //condicoes diferentes pra cada parametro de chamada da classe
        
        switch vcToPresent
        {
            
        case .ByThisTimeVController:
        
            view.addSubview(timePicker)
            NSLog("oi")
        
        case .KeepMeAwakeVController:
            
            NSLog("ola")
            
        case .NearLocationVController:
            
            NSLog("tchau")
            
        }
        
    
    }
    
    // botoes esquerda e direita
    
    func leftRightButtons(sender: UIButton)
    {
        if( sender.tag == 1)
        {
            vibrateLabel.hidden = false
            soundLabel.hidden = false
            tapLabel.hidden = false
            slideLabel.hidden = false
            vibrateSwitch.hidden = false
            soundSwitch.hidden = false
            tapSwitch.hidden = false
            slideSwitch.hidden = false
            if(soundSwitch.on==false)
            {
                timePicker.hidden = false
                soundPicker.hidden=true
            }
            else
            {
                soundPicker.hidden = false
                timePicker.hidden = true
            }
        }
        else
        {
            vibrateLabel.hidden = true
            soundLabel.hidden = true
            tapLabel.hidden = true
            slideLabel.hidden = true
            vibrateSwitch.hidden = true
            soundSwitch.hidden = true
            tapSwitch.hidden = true
            slideSwitch.hidden = true
            soundPicker.hidden = true
            timePicker.hidden = true
        }
        
    }
    
    
    // escolhe o modo q será apresentado o settings
    
    func setViewControllerToPresent(viewController: viewControllers)
    {
        vcToPresent = viewController
    }

    // Protocol UIPickerVIew
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 3
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        var label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 30))
        label.text = soundArray[row]
        
        return label
    }
    
    
    
    // Buttons Actions
    
    @IBAction func backMenu2(sender: UIButton)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    func okButtonPressed(sender: UIButton)
    {
        switch vcToPresent
        {
            case .ByThisTimeVController:
            
                let vc = ByThisTimeVController(nibName: "ByThisTimeVController", bundle: nil)
                soundName = soundArray[soundPicker.selectedRowInComponent(0)]
                println("soundName \(soundName)")
                var timeToWait: NSTimeInterval = timePicker.countDownDuration
                println("on \(vibrateSwitch.on) \(soundSwitch.on)")
                if(vibrateSwitch.on==true)
                {
                    if(soundSwitch.on==true)
                    {
                        vc.setToVibrateAndToPlaySound(soundName, ofType: ".mp3", timeToWait: timeToWait)
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
                        vc.setSoundToPlay(soundName, ofType: ".mp3", timeToWait: timeToWait)
                    }
                    else
                    {
                        println("ERROR");
                        return
                    }
                }
                
                self.presentViewController(vc, animated: false, completion: nil)
                
            case .KeepMeAwakeVController:
                
                var feedBackDic: NSMutableDictionary = NSMutableDictionary()
                feedBackDic.setValue("1", forKey: "tap")
                feedBackDic.setValue("0", forKey: "slide")
                feedBackDic.setValue("0", forKey: "wink")
                feedBackDic.setValue("0", forKey: "smile")
                
                let kmavc = KeepMeAwakeVController(nibName: "KeepMeAwakeVController", bundle: nil)
                kmavc.setToVibrate()
                kmavc.setFeedBackTypesAndTimeInterval(feedBackDic, timeInterval: 6)
                
                self.presentViewController(kmavc, animated: false, completion: nil)
                
                
            case .NearLocationVController:
            
                let vc = NearLocationVController(nibName: "NearLocationVController", bundle: nil)
                self.presentViewController(vc, animated: false, completion: nil)
                
                
        }
        
    }

    func soundSwitchChanged(sender: UISwitch) {
        timePicker.hidden = sender.on
        soundPicker.hidden = !sender.on
    }

}
