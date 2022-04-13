//
//  HomeView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct WorkoutsView: View {
    
    @EnvironmentObject var authState: AuthState
    @ObservedObject var vm = WorkoutsVM()
    @State var selection: Int? = nil
    @State var vms: [WorkoutVM] = []
    
    var body: some View {
        VStack {
            Text("Banner")
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(spacing: 10) {
                        if (vm.isLoading) {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        } else {
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(vm.viewModels, id: \.self) { viewModel in
                                    WorkoutCardView(vm: viewModel)
                                }
                            }
                        }
                    }
                }
                NavigationLink(destination: AddWorkoutView(), tag: 1, selection: $selection) {
                    Button(action: {
                        self.selection = 1
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .clipShape(Circle())
                            .font(.system(size: 55))
                            .shadow(color: .gray, radius: 1, x: 0, y: 2)
                    }
                    )
                        .padding()
                }
            }
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
