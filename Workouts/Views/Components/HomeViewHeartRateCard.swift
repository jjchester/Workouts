//
//  HomeViewCalsCard.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-15.
//

import SwiftUI

struct HomeViewHeartRateCard: View {
    @ObservedObject var vm: HomeViewModel

    init(vm: HomeViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.pink)
                .opacity(0.8)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 1, y: 3)
            if vm.isLoadingHeartrate {
                HStack {
                    Image(systemName: "bolt.heart")
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
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 50, weight: .heavy))
                        .frame(maxHeight: .infinity, alignment: .center)
                    VStack {
                        Text("Heartrate")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        HStack {
                            VStack {
                                Text("Range")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                Text("\(vm.heartRateLow!)-\(vm.heartRateHigh!) BPM")
                                    .font(.system(size: 16, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            }
                            VStack {
                                Text("Average")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                Text("\(vm.heartRateAvg!) BPM")
                                    .font(.system(size: 16, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
            }
        }
        .frame(minHeight: 120)
    }
}
