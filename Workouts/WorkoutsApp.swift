//
//  WorkoutsApp.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI
import Firebase

@main
struct WorkoutsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        let authState = AuthState()
        WindowGroup {
            LoginView()
                .environmentObject(authState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
