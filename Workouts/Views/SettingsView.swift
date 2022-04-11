//
//  SettingsView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct ProfileView: View {

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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
