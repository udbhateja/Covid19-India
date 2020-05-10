//
//  Cases.swift
//  Covid-19
//
//  Created by JBhateja on 02/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

struct Cases: Codable, Identifiable {

    let id = UUID()
    
    var active          : String?
    var confirmed       : String?
    var recovered       : String?
    var deaths          : String?
    
    var deltaConfirmed  : String?
    var deltaDeaths     : String?
    var deltaRecovered  : String?
    var deltaActive     : String?
    
    var state           : String?
    var stateCode       : String?
    
    var lastupdated     : String?
    
  
    
    mutating func format() {
        var newActive = 0
        
        if let data = deltaConfirmed {
            deltaConfirmed = "[+\(data)]"
            newActive = Int(data)!
        }
        if let data = deltaRecovered {
            deltaRecovered = "[+\(data)]"
            newActive -= Int(data)!
        }
        if let data = deltaDeaths {
            deltaDeaths = "[+\(data)]"
            newActive -= Int(data)!
        }
        
        deltaActive = "[+\(newActive)]"
    }
    
    private enum CodingKeys: String, CodingKey {
        case active
        case confirmed
        case recovered
        case deaths
        case deltaConfirmed = "deltaconfirmed"
        case deltaDeaths    = "deltadeaths"
        case deltaRecovered = "deltarecovered"
        case state
        case stateCode      = "statecode"
        case lastupdated    = "lastupdatedtime"
    }
}
