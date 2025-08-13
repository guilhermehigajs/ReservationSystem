//
//  BackgroundGrandient.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/9/25.
//

import SwiftUI

struct BackgroundGradient: View {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    static let defaultColors: [Color] = [
        Color(red: 0.996, green: 0.898, blue: 0.635),
        Color(red: 0.753, green: 0.686, blue: 0.486),
        Color(red: 0.6, green: 0.5, blue: 0.3)
    ]

    init(
        colors: [Color] = BackgroundGradient.defaultColors,
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint: endPoint
        )
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundGradient()
    
    BackgroundGradient(colors: [
        Color(red: 1.0, green: 0.976, blue: 0.769),
        Color(red: 0.773, green: 0.882, blue: 0.647)
    ])
}

