//
//  Readings.swift
//  bible
//
//  Created by Daniel Rodenberg on 5/7/15.
//  Copyright (c) 2015 DR. Inc. All rights reserved.
//

import Foundation

class Readings {
    let name: String?
    let readings: String?
    
    init(name: String?, readings: String?) {
        self.name = name ?? ""
        self.readings = readings ?? ""
    }
}