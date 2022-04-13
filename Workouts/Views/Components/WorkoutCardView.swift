//
//  WorkoutView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import SwiftUI

struct WorkoutCardView: View {
    
    @ObservedObject var vm: WorkoutVM
    
    init(vm: WorkoutVM) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationLink(destination: WorkoutDetailsView(vm: self.vm)) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(red: 0.99, green: 0.99, blue: 0.99))
                    .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 3)
                HStack {
                    switch vm.workoutType {
                    case "Cardio":
                        Image(systemName: "heart")
                            .foregroundColor(Color("brightPink"))
                            .font(.system(size: 40))
                            .frame(maxHeight: .infinity, alignment: .center)
                    case "Strength":
                        Image("barbell")
                            .renderingMode(.template)
                            .foregroundColor(Color("brightBlue"))
                            .font(.system(size: 60))
                            .frame(maxHeight: .infinity, alignment: .center)
                    case "Mixed":
                        Image(systemName: "arrow.up.heart")
                            .font(.system(size: 40))
                            .frame(maxHeight: .infinity, alignment: .center)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("brightPink"), Color("brightBlue")]), startPoint: .leading, endPoint: .trailing))
                    default:
                        ProgressView()
                    }
                    VStack {
                        Text(self.vm.workoutType)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(Helper.dateToString(date: self.vm.date))
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(self.vm.duration)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.leading)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                        .frame(alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
            }
            .frame(minHeight: 100)
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}
