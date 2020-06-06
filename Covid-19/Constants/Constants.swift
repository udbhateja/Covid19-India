//
//  Constants.swift
//  Covid-19
//
//  Created by JBhateja on 02/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

struct WebServiceURL {
    static let base = "https://api.covid19india.org/"
    
    static let nationalLevel    = base + "data.json"
    static let stateLevel       = base + "v2/state_district_wise.json"
    static let testing          = base + "state_test_data.json"
}



