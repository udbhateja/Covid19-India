//
//  StateView.swift
//  Covid-19
//
//  Created by JBhateja on 03/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import SwiftUI

// MARK: - StateView
struct StateView: View {
    
    // MARK: Body
    var body: some View {
        
        HStack {
            VStack {
                Text("Himachal Pradesh")
                Text("Last Updated on 06 May, 2020")
            }
            VStack {
                Text("Tested")
                Text("8000")
            }
        }
        
    }
}
