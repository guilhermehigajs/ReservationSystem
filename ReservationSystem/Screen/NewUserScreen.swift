//
//  NewUserScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/12/25.
//

import SwiftUI

struct NewUserScreen: View {
    
    let databaseManager: DatabaseManaging
    let newUserController: NewUserController
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var pinCode: String = ""
    @State private var categoryInput: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    init(databaseManager: DatabaseManaging) {
        self.databaseManager = databaseManager
        self.newUserController = NewUserController(database: databaseManager)
    }
    
    var body: some View {
        ZStack {
            BackgroundGradient(colors: [
                Color(red: 0.996, green: 0.898, blue: 0.635),
                Color(red: 0.753, green: 0.686, blue: 0.486),
                Color(red: 0.6, green: 0.5, blue: 0.3)
            ])
            ScrollView {
                VStack(spacing: 16) {
                    Text("Cadastro de Usuário")
                        .font(.title2)
                        .bold()
                        .padding(.top, 12)
                    
                    TextField("Nome", text: $name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(true)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                    
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                    
                    SecureField("PIN/Senha", text: $pinCode)
                        .keyboardType(.numberPad)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                    
                    TextField("Categoria", text: $categoryInput)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(14)
                        .padding(.horizontal, 40)
                    
                    Button {
                        guard let category = parseCategory(from: categoryInput) else {
                            alertMessage = "Categoria inválida. Use 1-4 ou host/server/manager/generalManager."
                            showAlert = true
                            return
                        }
                        let newUser = User(
                            id: UUID().uuidString,
                            name: name,
                            email: email,
                            pinCode: pinCode,
                            employeeCategory: category
                        )
                        alertMessage = "Usuário \(newUser.name) criado com sucesso."
                        showAlert = true
                        newUserController.registerNewUser(newUser)
                    } label: {
                        Text("Cadastrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 1.0, green: 0.718, blue: 0.302))
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                    }
                    .disabled(name.isEmpty || email.isEmpty || pinCode.isEmpty || categoryInput.isEmpty)
                    .opacity((name.isEmpty || email.isEmpty || pinCode.isEmpty || categoryInput.isEmpty) ? 0.6 : 1)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.top, 4)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .alert("Cadastro", isPresented: $showAlert) {
            Button("OK") { dismiss() }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func parseCategory(from input: String) -> EmployeeCategory? {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if let intVal = Int(trimmed) {
            return EmployeeCategory(rawValue: intVal)
        }
        switch trimmed {
        case "host": return .host
        case "server": return .server
        case "manager": return .manager
        case "generalmanager", "general manager", "gm": return .generalManager
        default: return nil
        }
    }
}


