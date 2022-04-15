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
        ScrollView {
            VStack {
                HomeViewCard(vm: self.viewModel)
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.top, 20)
        }
        .onAppear {
            viewModel.updateSteps()
        }
    }
}
