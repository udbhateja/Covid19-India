//
//  StateHeaderView.swift
//  Covid-19
//
//  Created by JBhateja on 16/06/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import SwiftUI


struct StateHeaderView: View {
    
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
                    
                    Text("TESTED")
                        .foregroundColor(.purple)
                        .font(.footnote)
                    
                    Text(tested)
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
