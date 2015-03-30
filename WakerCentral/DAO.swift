//
//  DAO.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 27/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import Foundation


class DAO
{
    func getAlarms() -> [Alarm]
    {
        var retorno:[Alarm] = []
        var alarm:Alarm = KeepMeAwakeAlarm(repeatIntervals: 1, tap: true, slide: true, smile: true, wink: true)
        retorno.append(alarm)
        alarm = ByThisTimeAlarm(timeToTrigger: 10, tap: false, slide: true, smile: true, wink: true)
        retorno.append(alarm)
        alarm = ByThisTimeAlarm(timeToTrigger: 50, tap: true, slide: false, smile: true, wink: true)
        retorno.append(alarm)
        alarm = ByThisTimeAlarm(timeToTrigger: 10, tap: false, slide: true, smile: false, wink: true)
        retorno.append(alarm)
        return retorno
    }
}