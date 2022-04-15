//
//  AnimatedGradient.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-15.
//

import SwiftUI

struct AnimatedGradient: View {
    
    @State var gradient = [Color(red: 0.98, green: 0.98, blue: 0.98).opacity(0.6), Color(red: 0.8, green: 0.8, blue: 0.8).opacity(0.6)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 0)
    private var width: CGFloat
    private var height: CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
            .frame(width: width, height: height)
            .onAppear {
                withAnimation (.linear(duration: 0.7).repeatForever()){
                    self.startPoint = UnitPoint(x: -1, y: 0)
                    self.endPoint = UnitPoint(x: 0, y: 0)
                }
        }
    }
}
