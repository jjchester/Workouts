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
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Steps card
                HomeViewStepCard(vm: self.viewModel)
                HomeViewCalsCard(vm: self.viewModel)
                HomeViewHeartRateCard(vm: self.viewModel)
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.top, 20)
        }
        .onAppear {
            viewModel.updateSteps()
        }
        .onReceive(timer) { _ in
            // Workaround for not being able to listen to health changes
            viewModel.updateSteps()
            viewModel.updateCalories()
        }
    }
}
