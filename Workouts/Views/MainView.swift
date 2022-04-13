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
    var profileView: ProfileView = ProfileView()
    var homeView: HomeView = HomeView()
    var workoutsView: WorkoutsView = WorkoutsView()
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView(selection: $selection) {
            homeView
                .environmentObject(authState)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tab.home)
            workoutsView
                .environmentObject(authState)
                .tabItem {
                    Image("dumbbell.SFSymbol")
                        .font(.system(size: 32))
                    Text("Workouts")
                }
                .tag(Tab.workouts)
            profileView
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
