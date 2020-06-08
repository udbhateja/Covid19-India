//
//  Cases_State.swift
//  Covid-19
//
//  Created by JBhateja on 06/06/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

struct Cases_District: CaseStats, Codable {
  
    var district        : String?
    var active          : Int?
    var confirmed       : Int?
    var recovered       : Int?
    var deaths          : Int?
    var deltaConfirmed  : Int?
    var deltaDeaths     : Int?
    var deltaRecovered  : Int?
    var deltaActive     : Int?
    
    private var delta   : Deltas? {
        didSet {
            deltaConfirmed  = delta?.confirmed
            deltaDeaths     = delta?.deaths
            deltaRecovered  = delta?.recovered
            deltaActive     = delta?.active
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case district
        case active
        case confirmed
        case recovered
        case delta
        case deaths         = "deceased"
    }
    
    // Coding Deltas
    private struct Deltas: Codable {
        
        var confirmed  : Int?
        var deaths     : Int?
        var recovered  : Int?
        var active     : Int? {
            return calculateActive()
        }

        private enum CodingKeys: String, CodingKey {
            case confirmed
            case deaths    = "deceased"
            case recovered
        }
        
        private func calculateActive() -> Int {
            var newActive = 0
            
            if let data = confirmed {
                newActive = data
            }
            if let data = recovered {
                newActive -= data
            }
            if let data = deaths {
                newActive -= data
            }
            
            return newActive
        }
    }
}


struct Cases_State: Codable {
    var state               : String?
    var districtCases       : [Cases_District]?
    var stateCode           : String?
    
    private enum CodingKeys: String, CodingKey {
        case state
        case districtCases  = "districtData"
        case stateCode      = "statecode"
    }
}

extension Array where Element == Cases_State {
    func objectFor(stateCode: String) -> Cases_State?  {
        return self.first(where: {
            $0.stateCode == stateCode
        })
    }
}
