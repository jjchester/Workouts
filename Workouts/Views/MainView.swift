//
//  MainView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI
import HealthKit

enum Tab {
    case home
    case workouts
    case profile
    case settings
}

struct MainView: View {
    
    @EnvironmentObject var authState: AuthState
    @State var selection: Tab = .home
    var profileView: ProfileView
    var homeView: HomeView
    var workoutsView: WorkoutsView
    var settingsView: SettingsView
    var healthStore: HKHealthStore?
    var healthController: HealthController = HealthController()
     
    init() {
        homeView = HomeView(viewModel: HomeViewModel(healthController: healthController))
        workoutsView = WorkoutsView()
        profileView = ProfileView()
        settingsView = SettingsView()
        UITabBar.appearance().backgroundColor = .white
        if (HKHealthStore.isHealthDataAvailable()) {
            let allTypes = Set([HKObjectType.workoutType(),
                                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                HKObjectType.quantityType(forIdentifier: .heartRate)!,
                                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                HKSeriesType.workoutType()])

            healthStore = HKHealthStore()
            healthStore!.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    print("Error retrieving health data: " + (error?.localizedDescription ?? " "))
                    return
                }
            }
        }
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
            settingsView
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(Tab.settings)
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
        case .settings:
            return "Settings"
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
