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
    
    
    
    var CellContentID : Int = Int() //Informs to the cell what it has to present
    
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
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
                println("2")
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
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





