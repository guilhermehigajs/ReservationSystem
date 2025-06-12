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

    init(
        colors: [Color],
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
    BackgroundGradient(colors: [
        Color(red: 1.0, green: 0.976, blue: 0.769),
        Color(red: 0.773, green: 0.882, blue: 0.647)
    ])
}

