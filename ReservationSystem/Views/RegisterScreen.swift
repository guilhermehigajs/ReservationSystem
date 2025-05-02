//
//  RegisterScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/1/25.
//

import SwiftUI

struct RegisterScreen: View {
    @State var name: String = ""
    @State private var email = ""
    @State private var pin = ""
    @State private var id = ""
    @State private var businessName = ""
    
    var body: some View {
        VStack {
            Text("Registration")
                .font(.largeTitle)
                .bold()
            TextField("Id", text: $id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            TextField("Nome", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            TextField("Pin", text: $pin)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            TextField("Phone", text: $pin)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            TextField("Business Name", text: $businessName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            HStack {
                Button(action: {
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal, 30)
                }
                Button(action: {
                }) {
                    Text("Clean")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal, 30)
                }
            }
        }
    }
}

#Preview {
    RegisterScreen()
}
