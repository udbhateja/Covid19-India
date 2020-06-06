//
//  StateListView.swift
//  Covid-19
//
//  Created by JBhateja on 03/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import SwiftUI

// MARK: - StateView
struct StateListView: View {
    
    init() {
        // To remove extra separators below the list
        UITableView.appearance().separatorColor = .clear
        UITableViewHeaderFooterView.appearance().tintColor = .white
    }
    
    // MARK: State Variables
    @State private var cases: [Cases_National] = []
    
    // MARK: Body
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: StateListItem(
                        font: Font.custom("Copperplate-Bold", size: 12.0),
                        alignment: .leading)
                        .padding(10.0)
                        .frame(minHeight:40.0)
                ) {
                    ForEach(cases.indices) { index in
                        ZStack {
                            NavigationLink(destination: self.stateView(for: index)) {
                                StateListItem(
                                    state       : self.item(index: index).state ?? "-",
                                    confirmed   : self.item(index: index).confirmed ?? "-",
                                    active      : self.item(index: index).active ?? "-",
                                    recovered   : self.item(index: index).recovered ?? "-",
                                    deceased    : self.item(index: index).deaths ?? "-"
                                ).padding(10.0)
                            }.padding(.trailing, -32.0)
                        }.listRowBackground((index  % 2 == 0) ? Color.gray.opacity(0.10) : Color.white)
                    }
                }
            }
            .navigationBarTitle("COVID19 INDIA")
        }
        .onAppear {
            NationalLevelData.get { (data) in
                self.cases = data.statesData ?? []
            }
        }
    }
    
    // MARK: Private functions
    private func item(index: Int) -> Cases_National {
        return cases[index]
    }
    
    private func stateView(for index: Int) -> StateView {
        StateView(stateCode     : cases[index].stateCode ?? "",
                  lastUpdated   : cases[index].lastupdated ?? "")
    }
}


// MARK: - State Detail List Item View
struct StateListItem: View {
    
    var state       = "State/UT"
    var confirmed   = "Cnfrmd"
    var active      = "Actv"
    var recovered   = "Rcvrd"
    var deceased    = "Dcsd"
    
    var font        = Font.custom("Cochin-Bold", size: 15.0)
    var alignment   = Alignment.trailing
    
    var body: some View {
        
        GeometryReader { metrics in
            
            HStack() {
                
                Text(self.state)
                    .font(self.font)
                    .frame(width: metrics.size.width * 0.40, alignment: .leading)
                    .lineLimit(5)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(self.confirmed)
                    .font(self.font)
                    .foregroundColor(.red)
                    .frame(width: metrics.size.width * 0.15, alignment: self.alignment)
                
                Text(self.active)
                    .font(self.font)
                    .foregroundColor(.blue)
                    .frame(width: metrics.size.width * 0.15, alignment: self.alignment)
                
                
                Text(self.recovered)
                    .font(self.font)
                    .foregroundColor(.green)
                    .frame(width: metrics.size.width * 0.15, alignment: self.alignment)
                
                Text(self.deceased)
                    .font(self.font)
                    .foregroundColor(.gray)
                    .frame(width: metrics.size.width * 0.15, alignment: .leading)
            }
        }
    }
}

