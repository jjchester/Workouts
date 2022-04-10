//
//  SettingsView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var authState: AuthState

    var body: some View {
        List {
            Section(header: Text("Account")) {
                Button(action: {
                    authState.signOut()
                }, label: {
                    Text("Sign Out")
                        .foregroundColor(Color.blue)
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
