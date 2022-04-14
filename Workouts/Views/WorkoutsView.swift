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
            Rectangle()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 1)
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(spacing: 10) {
                        if (vm.isLoading) {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        } else {
                            if (vm.models.count == 0) {
                                Text("Add a workout with the \"+\" button")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 150)
                            }
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
                        Image(systemName: "plus")
                            .padding(6)
                            .foregroundColor(Color("brightBlue"))
                            .background(Color(red: 0.99, green: 0.99, blue: 0.99))
                            .clipShape(Circle())
                            .font(.system(size: 34, weight: .light))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
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
