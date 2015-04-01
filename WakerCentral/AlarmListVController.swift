//
//  AlarmListVController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 27/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit

class AlarmListVController: UITableViewController
{
    
    var dao : DAO = DAO()
    var alarms : [Alarm] = []
    
    var backBt: UIButton = UIButton(frame: CGRectMake(15 ,27 , 30 , 30))
    var plusBt: UIButton = UIButton (frame: CGRectMake(280, 27, 30, 30))


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.alarms = dao.getAlarms()
        
        
        backBt.setImage(UIImage(named: "backButton"), forState: UIControlState.Normal)
        backBt.addTarget(self, action: Selector("backConfig:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        plusBt.setImage(UIImage(named: "maisButton"), forState: UIControlState.Normal)
        plusBt.addTarget(self, action: Selector("backSave:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //Add o elememento na tela
        
        view.addSubview(backBt)
        view.addSubview(plusBt)
        
    }
    
    @IBAction func backSave(sender: UIButton)
    {
    }
    
    @IBAction func backConfig(sender: UIButton)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be rereated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return alarms.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell = UITableViewCell();
        cell = tableView.dequeueReusableCellWithIdentifier("alarmsList", forIndexPath: indexPath) as UITableViewCell
        
//        if (cell == nil)
//        {
//            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "alarmsList")
//        }

        if (alarms[indexPath.row] is NearLocationAlarm)
        {
            //TODO: definir a imagem da célula como tipo "NearLocation"
        }
        else if (alarms[indexPath.row] is ByThisTimeAlarm)
        {
            //TODO: definir a imagem da célula como tipo "ByThisTimeAlarm"
        }
        else
        {
            //TODO: definir a imagem da célula como tipo "KeepMeAwakeAlarm"
        }
        
        cell.detailTextLabel?.text = "Descrição do Alarm (usem aqui várias informações, como horário, etc."
        // cell.detailTextLabel?.text = alarms[indexPath.row].descricao
        cell.textLabel?.text = "Título da célula (Acordar, etc)"
        // cell.textLabel?.text = alarms[indexPath.row].titulo
        
        // Configure the cell...

        return cell
    }

    
}
