//
//  Alarm.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 27/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

//This Class implement the model of the alarms and their data
import Foundation

class Alarm
{
    private var feedbacks : Dictionary <String, Bool>
    var titulo: String = ""
    var descricao: String = ""
    
    init(tap: Bool,slide : Bool, smile: Bool,  wink : Bool)
    {
        self.feedbacks = Dictionary<String, Bool>()
        
        self.feedbacks.updateValue(tap, forKey: "tap")
        self.feedbacks.updateValue(slide, forKey: "slide")
        self.feedbacks.updateValue(smile, forKey: "smile")
        self.feedbacks.updateValue(wink, forKey:  "wink")
    }
    
    func trigger()
    {
        //TODO: implementar metodo para disparar o alarm
    }
    func stop()
    {
        //TODO: mplementar metodo stop
    }
    
}