//
//  ViewController.swift
//  ExpandingTableView
//
//  Created by Andreia de Sa on 01/04/15.
//  Copyright (c) 2015 Andreia de Sa. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "cell"
    var tableData = [String]()
    var expanded: Int = 0
    var selectedCellIndexPath: NSIndexPath?
    let SelectedCellHeight: CGFloat = 150.0
    let UnselectedCellHeight: CGFloat = 50.0
    
    var vibrateSwitch: UISwitch = UISwitch(frame: CGRectMake(250, 40, 40, 20))
    var soundSwitch: UISwitch = UISwitch(frame: CGRectMake(250, 10, 40, 20))
    var tapSwitch: UISwitch = UISwitch(frame: CGRectMake(250, 45, 40, 20))
    var slideSwitch: UISwitch  = UISwitch(frame: CGRectMake(250, 80, 40, 20))
    var smileSwitch: UISwitch  = UISwitch(frame: CGRectMake(250, 115, 40, 20))
    
    var vibrateLabel: UILabel = UILabel(frame: CGRectMake(150, 40, 70, 30))
    var soundLabel: UILabel = UILabel(frame: CGRectMake(150, 10, 70, 30))
    var tapLabel: UILabel = UILabel(frame: CGRectMake(150, 42, 70, 30))
    var slideLabel: UILabel = UILabel(frame: CGRectMake(150,74,  70, 30))
    var smileLabel: UILabel = UILabel(frame: CGRectMake(150, 106, 70, 30))
    
    var expandTimer: NSTimer = NSTimer()
    var ds:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var parentVC: SetModeVController!
    
    var CellContentID : Int = Int() //Informs to the cell what it has to present
    var DrawCellContentID: Int = 0
    
     func isSwitchOn(switchName:String) -> Bool
    {
        if (switchName == "vibrate")
        {
            return  vibrateSwitch.on
        }
        else if( switchName == "sound")
        {
            return soundSwitch.on;
        }
        else if (switchName == "tap")
        {
            return  tapSwitch.on
        }
        else if( switchName == "slide")
        {
            return slideSwitch.on;
        }
        else if( switchName == "smile")
        {
            return slideSwitch.on;
        }

        NSLog("ERROR SWITCH NOT FOUND!\n returning FALSE\n")
        return false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vibrateSwitch.onTintColor = UIColor(red: 211/255.0, green: 129/255.0, blue: 54/255.0, alpha: 1.0)
        soundSwitch.onTintColor = UIColor(red: 211/255.0, green: 129/255.0, blue: 54/255.0, alpha: 1.0)
        tapSwitch.onTintColor = UIColor(red: 211/255.0, green: 129/255.0, blue: 54/255.0, alpha: 1.0)
        slideSwitch.onTintColor = UIColor(red: 211/255.0, green: 129/255.0, blue: 54/255.0, alpha: 1.0)
        smileSwitch.onTintColor = UIColor(red: 211/255.0, green: 129/255.0, blue: 54/255.0, alpha: 1.0)
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor = UIColor(red: 197/255.0, green: 124/255.0, blue: 46/255.0, alpha: 1.0)
        //parentVC = self.parentViewController as SetModeVController
        
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        for index in 0 ... 100{
            
            self.tableData.append("Item \(index)")

    
    }
        
        
        
       
        tableData[0] = "General Settings";
        tableData[1] = "Feedbacks"
        
        vibrateSwitch.hidden=true
        soundSwitch.hidden=true
        tapSwitch.hidden=true
        slideSwitch.hidden=true
        smileSwitch.hidden=true
        
        vibrateLabel.text="Vibrate"
        soundLabel.text="Sound"
        tapLabel.text="tap"
        slideLabel.text="slide"
        smileLabel.text="Smile"
        vibrateLabel.hidden=true
        soundLabel.hidden=true
        tapLabel.hidden=true
        slideLabel.hidden=true
        smileLabel.hidden=true
        
        //default values
        smileSwitch.on = true
        vibrateSwitch.on=true
        soundSwitch.on=false
        tapSwitch.on=true
        slideSwitch.on=false
        saveSwitches()
        
        
        // tirar as celulas vazias
        tableView.tableFooterView = UIView (frame:CGRectZero)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveSwitches", name: "getSwitches", object: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        saveSwitches()
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        saveSwitches()
        return 2
    }
   
    override  func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!)
    {
        println("Performed")
        saveSwitches()
    }
    
    //Chamado apenas uma vez , quando a tabela carrega, por isso não há clones
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        
        println("Subs \(indexPath.row)")
        
        cell.backgroundColor = UIColor(red: 222/255.0, green: 196/255.0, blue: 167/255.0, alpha: 1.0)
        
        if(indexPath.row==1)
        {
        
        cell.addSubview(soundSwitch)
        cell.addSubview(tapSwitch)
        cell.addSubview(slideSwitch)
        cell.addSubview(smileSwitch)
        
       
        cell.addSubview(soundLabel)
        cell.addSubview(tapLabel)
        cell.addSubview(slideLabel)
        cell.addSubview(smileLabel)
        }
        else
        {
            cell.addSubview(vibrateSwitch)
            cell.addSubview(vibrateLabel)
        }
        
        cell.textLabel?.text = self.tableData[indexPath.row]
        cell.textLabel?.textAlignment = .Natural
        
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 222/255.0, green: 196/255.0, blue: 167/255.0, alpha: 1.0)
        
        println("1")
        
        if let selectedCellIndexPath = selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                self.selectedCellIndexPath = nil
            } else {
                self.selectedCellIndexPath = indexPath
            }
        } else {
            selectedCellIndexPath = indexPath
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        saveSwitches()
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
                println("2")
        if let selectedCellIndexPath = selectedCellIndexPath
        {
            if selectedCellIndexPath == indexPath
            {
                CellContentID = indexPath.row
                //drawCellObjects()
                DrawCellContentID = indexPath.row
                expandTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "drawCellObjects", userInfo: nil, repeats: false)
                return SelectedCellHeight
                
            }
        }
        CellContentID = indexPath.row
        EraseCellObjects(indexPath)
        
        return UnselectedCellHeight
        
        //        if(indexPath.row == expanded){
        //            return 180
        
        //        }
        
        //        return rowHeight
        
        
    }
    func drawCellObjects()
    {
        var cell : UITableViewCell
        println("draw")
        switch(DrawCellContentID)
        {
        case 0:
            vibrateSwitch.hidden=false

            vibrateLabel.hidden=false

            
            break;
        case 1:
            //cell = self.tableView.cellForRowAtIndexPath(mode)!
            soundSwitch.hidden=false
            tapSwitch.hidden=false
            slideSwitch.hidden=false
            smileSwitch.hidden=false
            
            soundLabel.hidden=false
            tapLabel.hidden=false
            slideLabel.hidden=false
            smileLabel.hidden=false
            
           
            break;
        default:
            break;
        }
        saveSwitches()
        
    }
    func EraseCellObjects(mode: NSIndexPath)
    {
            println("Erase")
        switch(CellContentID)
        {
        case 0:
            vibrateSwitch.hidden=true
            
            vibrateLabel.hidden=true


            
            break;
        case 1:
            //cell = self.tableView.cellForRowAtIndexPath(mode)!
            soundSwitch.hidden=true
            tapSwitch.hidden=true
            slideSwitch.hidden=true
            smileSwitch.hidden=true
            
            soundLabel.hidden=true
            tapLabel.hidden=true
            slideLabel.hidden=true
            smileLabel.hidden=true
            
            
            break;
        default:
            break;
        }
//        parentVC.vibrateSwitch.on = vibrateSwitch.on
//        parentVC.soundSwitch.on = soundSwitch.on
          saveSwitches()

    
    }
    func saveSwitches()
    {
        NSLog("Saved Switches")
        ds.setBool( vibrateSwitch.on, forKey: "vibrate")
        ds.setBool( soundSwitch.on, forKey: "sound")
        ds.setBool(tapSwitch.on, forKey: "tap")
        ds.setBool( smileSwitch.on, forKey: "smile")
        ds.setBool(slideSwitch.on, forKey: "slide")
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





