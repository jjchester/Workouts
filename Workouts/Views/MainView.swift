//
//  MainView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

enum Tab {
    case home
    case workouts
    case profile
}

struct MainView: View {
    
    @EnvironmentObject var authState: AuthState
    @State var selection: Tab = .home
    
    init() {
        //UITabBar.appearance().backgroundColor = .systemGray6
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .environmentObject(authState)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tab.home)
            WorkoutsView()
                .environmentObject(authState)
                .tabItem {
                    Image("dumbbell_40px")
                        .renderingMode(.template)
                    Text("Workouts")
                }
                .tag(Tab.workouts)
            ProfileView()
                .environmentObject(authState)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
        .navigationTitle(getNavigationTitle())
    }
    
    func getNavigationTitle() -> String{
        switch selection {
        case .home:
            return "Home"
        case .workouts:
            return "Workouts"
        case .profile:
            return "Profile"
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
