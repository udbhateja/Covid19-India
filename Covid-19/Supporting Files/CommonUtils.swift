//
//  CommonUtils.swift
//  Covid-19
//
//  Created by JBhateja on 06/06/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

class CommonUtils {
    
    private static var dateFormatter: DateFormatter = {
        return DateFormatter()
    }()
    
    class func dateFormatted(_ string: String) -> String {
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = dateFormatter.date(from: string)
        
        dateFormatter.dateFormat = "dd MMM, HH:mm"
        if let _date = date {
            return dateFormatter.string(from: _date)
        }
        
        return string
    }
    
    
    class func format(lastUpdated: String) -> String {
        let formattedDate = dateFormatted(lastUpdated) + " IST"
        return "Last Updated: \(formattedDate)"
    }
    
}
