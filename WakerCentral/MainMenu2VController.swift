//
//  MainMenu2VController.swift
//  WakerCentral
//
//  Created by Leonardo Edelman Wajnsztok on 18/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit

class MainMenu2VController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clearColor()
        
        var popUpMenu: UIImageView = UIImageView(image: UIImage(named: "bgmenu2"))
        popUpMenu.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        popUpMenu.alpha = 0.8
        
        var cancelButton: UIButton = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.width / 1.5, 30, 80, 30))
        cancelButton.setImage(UIImage(named: "cancel"), forState: .Normal)
        cancelButton.addTarget(self, action: Selector("cancelButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        view.addSubview(popUpMenu)
        view.addSubview(cancelButton)
        
    }

    
    func cancelButtonAction()
    {
        self.dismissViewControllerAnimated(false, completion: nil)
        
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
