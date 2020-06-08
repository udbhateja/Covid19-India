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
    @State private var data: Cases_State?
    @State private var dist: [Cases_District] = []
    
    private var state: Binding<String> {
        return Binding.constant(data?.state ?? stateCode)
    }
    
    
    // MARK: Body
    var body: some View {
        VStack {
            StateHeaderView(state: state,
                            lastUpdated: Binding.constant(lastUpdated), tested: "5000")
            DistrictListView(cases: $dist)
        }.onAppear {
            self.request.getFor(stateCode: self.stateCode) { (cases, error) in
                self.data = cases?.first
                self.dist = cases?.first?.districtCases ?? []
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
                    .frame(minHeight:40.0)
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

private struct StateHeaderView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Binding var state          : String
    @Binding var lastUpdated    : String
    var tested                  : String
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
                    .frame(width: 25.0, height: 25.0, alignment: .center)
            }.padding(.leading, 8.0)
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    
                    Text(state)
                        .foregroundColor(.red)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(CommonUtils.format(lastUpdated: lastUpdated))
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    
                    Text("") //TESTED
                        .foregroundColor(.purple)
                        .font(.footnote)
                    
                    Text("") //8000
                        .foregroundColor(.purple)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .padding(8.0)
        }
    }
}
