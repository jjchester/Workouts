//
//  HomeView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct WorkoutsView: View {
    
    @EnvironmentObject var authState: AuthState

    var body: some View {
        VStack {
            Text("Workouts")
                .padding()
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
