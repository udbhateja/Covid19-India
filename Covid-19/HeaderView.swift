//
//  HeaderView.swift
//  Covid-19
//
//  Created by JBhateja on 02/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Text("COVID19")
                    .foregroundColor(Color.black)
                    .font(Font.custom("MarkerFelt-Wide", size: 24.0))
                Text("INDIA")
                    .foregroundColor(Color.blue)
                    .font(Font.custom("MarkerFelt-Wide", size: 24.0))
            }
            .padding(.top, 8.0)
            .padding(.bottom, 32.0)
        }
    }
}
