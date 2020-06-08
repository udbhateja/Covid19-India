//
//  HomeView.swift
//  Covid-19
//
//  Created by JBhateja on 02/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import SwiftUI

// MARK: - HomeView
struct HomeView: View {
    
    // MARK: State Variables
    @State private var cases: Cases_National?
    
    // MARK: Private Variables
    private var items: [HomeItemView] {
        return [
            HomeItemView(
                title: "Confirmed",
                value: cases?.confirmed ?? "-",
                delta: cases?.deltaConfirmed ?? "-",
                color: .red
            ),
            
            HomeItemView(
                title: "Active",
                value: cases?.active ?? "-",
                delta: cases?.deltaActive ?? "-",
                color: .blue
            ),
            
            HomeItemView(
                title: "Recovered",
                value: cases?.recovered ?? "-",
                delta: cases?.deltaRecovered ?? "-",
                color: .green
            ),
            
            HomeItemView(
                title: "Deceased",
                value: cases?.deaths ?? "-",
                delta: cases?.deltaDeaths ?? "-",
                color: .gray
            ),
        ]
    }
    
    private var request: NationalLevelServiceRequest = NationalLevelServiceRequest()
    
    // MARK: Body
    var body: some View {
        
        VStack {
            VStack {
                HStack(alignment: .center, spacing: 10.0) {
                    items[0]
                    items[1]
                }
                HStack(alignment: .center, spacing: 10.0) {
                    items[2]
                    items[3]
                }
            }
            .padding(.bottom, 24.0)
            
            Text(CommonUtils.format(lastUpdated: cases?.lastupdated ?? ""))
                .italic()
                .fontWeight(.light)
                .font(.system(size: 12.0))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 8.0)
                .padding(.bottom, 4.0)
        }
        .onAppear {
            NationalLevelData.get { (data) in
                self.cases = data.totalSummary
                self.cases?.format()
            }
        }
    }
}



// MARK: - HomeItemView
struct HomeItemView: View {
    
    var title   : String
    var value   : String
    var delta   : String
    var color   : Color
    
    var body: some View {
        
        VStack {
            Text(title)
                .foregroundColor(color)
                .font(Font.custom("Copperplate-Bold", size: 16.0))
                .padding(16.0)
            
            Spacer()
            
            Text(delta)
                .foregroundColor(color.opacity(0.75))
                .font(Font.custom("Cochin-Bold", size: 24.0))
                .padding(8.0)
            
            Spacer()
            
            Text(value)
                .foregroundColor(color)
                .font(Font.custom("Cochin-Bold", size: 32.0))
                .padding(16.0)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(color, lineWidth: 1.0))
            .padding()
    }
}
