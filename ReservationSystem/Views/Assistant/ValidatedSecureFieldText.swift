//
//  ValidatedSecureFieldText.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/13/25.
//

import SwiftUI

struct ValidatedSecureFieldText: View {
    let title: String
    @Binding var text: String
    let validate: (String) -> Bool
    let errorMessage: String
    
    @State private var edited = false
    private var isValid: Bool { validate(text) }
    private var showError: Bool { edited && !isValid }
    
    var body: some View {
        VStack(spacing: 6) {
            SecureField(title, text: $text)
                .padding()
                .frame(height: 50)
                .background(Color.white.opacity(0.9))
                .cornerRadius(14)
                .padding(.horizontal, 40)
                .onChange(of: text) { _ in
                    edited = true
                }
            
            if showError {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
