//
//  HomeView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authState: AuthState
    @ObservedObject var viewModel: HomeViewModel
    @State var steps: Double?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Signed in")
                .padding()
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(String(viewModel.steps!))
            }
        }
        .onAppear {
            viewModel.updateSteps()
        }
    }
}
