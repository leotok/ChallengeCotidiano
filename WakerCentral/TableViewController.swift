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
    
    var vibrateSwitch: UISwitch = UISwitch(frame: CGRectMake(250, 0, 40, 20))
    var soundSwitch: UISwitch = UISwitch(frame: CGRectMake(250, 30, 40, 20))
    var tapSwitch: UISwitch = UISwitch(frame: CGRectMake(250, 60, 40, 20))
    var slideSwitch: UISwitch  = UISwitch(frame: CGRectMake(250, 90, 40, 20))
    var smileSwitch: UISwitch  = UISwitch(frame: CGRectMake(250, 120, 40, 20))
    
    var vibrateLabel: UILabel = UILabel(frame: CGRectMake(150, 0, 70, 30))
    var soundLabel: UILabel = UILabel(frame: CGRectMake(150, 30, 70, 30))
    var tapLabel: UILabel = UILabel(frame: CGRectMake(150, 60, 70, 30))
    var slideLabel: UILabel = UILabel(frame: CGRectMake(150,90,  70, 30))
    var smileLabel: UILabel = UILabel(frame: CGRectMake(150, 120, 70, 30))
    
    
    
    var CellContentID : Int = Int() //Informs to the cell what it has to present
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vibrateSwitch.onTintColor = UIColor.orangeColor()
        soundSwitch.onTintColor = UIColor.orangeColor()
        tapSwitch.onTintColor = UIColor.orangeColor()
        slideSwitch.onTintColor = UIColor.orangeColor()
        smileSwitch.onTintColor = UIColor.orangeColor()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        for index in 0 ... 100{
            
            self.tableData.append("Item \(index)")

    
    }
        tableData[0] = "General Configurations";
        tableData[1] = "Responsive"
        
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
        
        
        // tirar as celulas vazias
        tableView.tableFooterView = UIView (frame:CGRectZero)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    //Chamado apenas uma vez , quando a tabela carrega, por isso não há clones
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        
        println("Subs \(indexPath.row)")
        
        cell.backgroundColor = UIColor.orangeColor()
        
        
        if(indexPath.row==1)
        {
        cell.addSubview(vibrateSwitch)
        cell.addSubview(soundSwitch)
        cell.addSubview(tapSwitch)
        cell.addSubview(slideSwitch)
        cell.addSubview(smileSwitch)
        
        cell.addSubview(vibrateLabel)
        cell.addSubview(soundLabel)
        cell.addSubview(tapLabel)
        cell.addSubview(slideLabel)
        cell.addSubview(smileLabel)
        }
        
        cell.textLabel?.text = self.tableData[indexPath.row]
        cell.textLabel?.textAlignment = .Natural
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        if let selectedCellIndexPath = selectedCellIndexPath
        {
            if selectedCellIndexPath == indexPath
            {
                CellContentID = indexPath.row
                DrawCellObjects(indexPath)
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
    func DrawCellObjects(mode: NSIndexPath)
    {
        var cell : UITableViewCell
        println("draw")
        switch(CellContentID)
        {
        case 0:
            
            
            break;
        case 1:
            //cell = self.tableView.cellForRowAtIndexPath(mode)!
            vibrateSwitch.hidden=false
            soundSwitch.hidden=false
            tapSwitch.hidden=false
            slideSwitch.hidden=false
            smileSwitch.hidden=false
            
            vibrateLabel.hidden=false
            soundLabel.hidden=false
            tapLabel.hidden=false
            slideLabel.hidden=false
            smileLabel.hidden=false
            
           
            break;
        default:
            break;
        }
        
        
    }
    func EraseCellObjects(mode: NSIndexPath)
    {
            println("Erase")
        switch(CellContentID)
        {
        case 0:
            
            
            break;
        case 1:
            //cell = self.tableView.cellForRowAtIndexPath(mode)!
            vibrateSwitch.hidden=true
            soundSwitch.hidden=true
            tapSwitch.hidden=true
            slideSwitch.hidden=true
            smileSwitch.hidden=true
            
            vibrateLabel.hidden=true
            soundLabel.hidden=true
            tapLabel.hidden=true
            slideLabel.hidden=true
            smileLabel.hidden=true
            
            
            break;
        default:
            break;
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




