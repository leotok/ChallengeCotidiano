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
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.alarms = dao.getAlarms()
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool 
    {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) 
    {
        if editingStyle == .Delete
        {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } 
        else if editingStyle == .Insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) 
    {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool 
    {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
