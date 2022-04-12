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
    var vms: [WorkoutVM] = []
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(spacing: 10) {
                        if (vm.isLoading) {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        } else {
                            ForEach(vm.docIds, id: \.self) { docId in
                                WorkoutCardView(vm: WorkoutVM(docId: docId))
                            }
                        }
                    }
                }
                NavigationLink(destination: AddWorkoutView(), tag: 1, selection: $selection) {
                    Button(action: {
                        self.selection = 1
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .padding()
                    }
                    )
                        .frame(alignment: .bottomTrailing)
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
