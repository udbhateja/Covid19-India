//
//  CaseStats.swift
//  Covid-19
//
//  Created by JBhateja on 06/06/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

protocol CaseStats {
    
    associatedtype T
    
    var active          : T? { get set }
    var confirmed       : T? { get set }
    var recovered       : T? { get set }
    var deaths          : T? { get set }
    
    var deltaConfirmed  : T? { get set }
    var deltaDeaths     : T? { get set }
    var deltaRecovered  : T? { get set }
    var deltaActive     : T? { get set }
}
