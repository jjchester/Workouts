//
//  HomeView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authState: AuthState

    var body: some View {
        VStack {
            Text("Signed in")
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
