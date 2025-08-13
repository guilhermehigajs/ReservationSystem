//
//  InputFieldStyle.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/13/25.
//

import SwiftUI

struct InputFieldStyle: ViewModifier {
    var showError: Bool

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 50)
            .background(Color.white.opacity(0.9))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(showError ? Color.red : Color.clear, lineWidth: 1)
            )
    }
}

extension View {
    func inputFieldStyle(showError: Bool = false) -> some View {
        self.modifier(InputFieldStyle(showError: showError))
    }
}
