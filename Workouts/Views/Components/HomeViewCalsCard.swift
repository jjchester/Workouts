//
//  HomeViewCalsCard.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-15.
//

import SwiftUI

struct HomeViewCalsCard: View {
    @ObservedObject var vm: HomeViewModel

    init(vm: HomeViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.red)
                .opacity(0.8)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 3)
            if vm.isLoadingCals || vm.isLoadingWeeklyCalories {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .frame(maxHeight: .infinity, alignment: .center)
                    VStack(alignment: .leading) {
                        AnimatedGradient(width: 140, height: 28)
                        AnimatedGradient(width: 160, height: 18)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding()
            } else {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .frame(maxHeight: .infinity, alignment: .center)
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Calories")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing)
                            
                            Text(String(vm.calories!))
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Weekly Average \(vm.averageWeeklyCalories!)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
        }
        .frame(minHeight: 120)
    }
}
