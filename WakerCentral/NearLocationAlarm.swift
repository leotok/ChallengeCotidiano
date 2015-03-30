//
//  NearLocationAlarm.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 27/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import Foundation
import CoreLocation

class NearLocationAlarm: Alarm
{
    var location: CLLocation!
    
    init(location: CLLocation, tap: Bool,slide : Bool, smile: Bool,  wink : Bool)
    {
        super.init(tap: tap,slide : slide, smile: smile,  wink : wink)
        self.location = location
    }
    
}