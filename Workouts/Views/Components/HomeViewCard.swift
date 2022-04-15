//
//  HomeViewCard.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-15.
//

import SwiftUI

struct HomeViewCard: View {
    @ObservedObject var vm: HomeViewModel
    
    init(vm: HomeViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.blue)
                .opacity(0.8)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 3)
            if vm.isLoadingSteps || vm.isLoadingWeeklySteps{
                HStack {
                    Image(systemName: "figure.walk")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .frame(maxHeight: .infinity, alignment: .center)
                    VStack(alignment: .leading) {
                        AnimatedGradient(width: 140, height: 28)
                        AnimatedGradient(width: 160, height: 18)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                }
                .padding()
            } else {
                HStack {
                    Image(systemName: "figure.walk")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .frame(maxHeight: .infinity, alignment: .center)
                    VStack {
                        Text(String(vm.steps!) + " steps")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text("Weekly average: \(vm.weeklySteps!)")
                            .font(.system(size: 18, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                }
                .padding()
            }
        }
        .frame(height: 120)
    }
}
