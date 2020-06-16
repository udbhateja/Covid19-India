//
//  Stats_Test.swift
//  Covid-19
//
//  Created by JBhateja on 16/06/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

struct Stats_Test: Codable {
    var tested                      : String?
    var state                       : String?
    private var updatedOn           : String?
   
    private enum CodingKeys: String, CodingKey {
        case tested         = "totaltested"
        case updatedOn      = "updatedon"
        case state
    }
}
