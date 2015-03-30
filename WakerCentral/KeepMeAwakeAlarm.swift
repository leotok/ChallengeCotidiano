//
//  KeepMeAwakeAlarm.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 27/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import Foundation

class KeepMeAwakeAlarm: Alarm
{
    var repeatIntervals: NSTimeInterval!
    
    init(repeatIntervals: NSTimeInterval, tap: Bool,slide : Bool, smile: Bool,  wink : Bool)
    {
        super.init(tap: tap,slide : slide, smile: smile,  wink : wink)
        self.repeatIntervals = repeatIntervals
    }
    
}