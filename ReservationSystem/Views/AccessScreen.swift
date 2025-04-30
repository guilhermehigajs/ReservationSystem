//
//  AccessScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 4/29/25.
//

import SwiftUI

struct AccessScreen: View {
    
    @State private var firstDigit: String = ""
    
    var body: some View {
        VStack {
            Image("ReservationSystemLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            HStack {
                TextField("", text: $firstDigit)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 160, height: 40)
            }
            Button(action: {
            }) {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
            }
            Button(action: {
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
            }
            Text("Version 1.0")
                .font(.caption)
        }
    }
}

#Preview {
    AccessScreen()
}
