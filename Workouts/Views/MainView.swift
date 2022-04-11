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
                    Image(systemName: "house")
                    Text("Home")
                }
            WorkoutsView()
                .environmentObject(authState)
                .tabItem {
                    Image("dumbbell_icon")
                        .renderingMode(.template)
                    Text("Workouts")
                }
            ProfileView()
                .environmentObject(authState)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
