//
//  Config.swift
//  Parkiller Demo
//
//  Created by Jesus Santa Olalla on 8/11/16.
//  Copyright © 2016 jsolalla. All rights reserved.
//

import Foundation

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
    
}