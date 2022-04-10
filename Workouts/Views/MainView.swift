//
//  MainView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authState: AuthState

    var body: some View {
        TabView {
            HomeView()
                .environmentObject(authState)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SettingsView()
                .environmentObject(authState)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
