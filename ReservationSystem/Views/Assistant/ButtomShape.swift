//
//  ButtomShape.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/13/25.
//

import SwiftUI

struct ButtomShape: View {
    let title: String
    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 1.0, green: 0.718, blue: 0.302))
                .cornerRadius(20)
                .padding(.horizontal, 40)
        }
    }
}
