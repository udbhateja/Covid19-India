//
//  AppView.swift
//  Covid-19
//
//  Created by JBhateja on 29/04/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Home")
            }
            StateListView()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("States")
            }
        }
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}




