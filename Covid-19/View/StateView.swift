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
    
    private let request = StateLevelServiceRequest()
    
    var stateCode   : String
    var lastUpdated : String
    
    // MARK: State Variables
    @State private var tested   : String?
    @State private var data     : Cases_State?
    @State private var dist     : [Cases_District] = []
    
    private var state: Binding<String> {
        return Binding.constant(data?.state ?? stateCode)
    }
    
    
    // MARK: Body
    var body: some View {
        VStack {
            StateHeaderView(
                state: state,
                lastUpdated: Binding.constant(lastUpdated),
                tested: tested ?? ""
            )
            DistrictListView(cases: $dist)
        }.onAppear {
            self.getData()
        }
    }
    
    // MARK: Functions
    private func getData() {
        request.getFor(stateCode: self.stateCode) { (cases, error) in
            self.data = cases?.first
            self.dist = cases?.first?.districtCases ?? []
            
            TestingData.dataFor(state: cases?.first?.state ?? "") { (testData) in
                self.tested = testData?.tested ?? "NA"
            }
        }
    }
}

// MARK: - District List
struct DistrictListView: View {
    
    @Binding var cases: [Cases_District]
    
    var body: some View {
        List {
            Section(
                header: StateListItem(
                    state: "District",
                    font: Font.custom("Copperplate-Bold", size: 12.0),
                    alignment: .leading)
                    .padding(10.0)
                    .frame(minHeight:50.0)
            ) {
                ForEach(cases.indices, id: \.self) { index in
                    StateListItem(
                        state       : self.item(index: index).district ?? "-",
                        confirmed   : "\(self.item(index: index).confirmed ?? 0)",
                        active      : "\(self.item(index: index).active ?? 0)",
                        recovered   : "\(self.item(index: index).recovered ?? 0)",
                        deceased    : "\(self.item(index: index).deaths ?? 0)"
                    )
                        .padding(10.0)
                        .frame(minHeight: 45.0)
                        .listRowBackground((index  % 2 == 0) ? Color.gray.opacity(0.10) : Color.white)
                }
            }
        }
    }
    
    // MARK: Private functions
    private func item(index: Int) -> Cases_District {
        return cases[index]
    }
}
