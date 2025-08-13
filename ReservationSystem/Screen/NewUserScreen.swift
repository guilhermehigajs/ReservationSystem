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
    
    @State private var nameEdited = false
    @State private var nameError: String?
    
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
            BackgroundGradient()
            ScrollView {
                VStack(spacing: 16) {
                    Text(Constant.NewUser.title)
                        .font(.title2)
                        .bold()
                        .padding(.top, 12)
                    
                    VStack(spacing: 6) {
                        ValidatedTextField(
                            title: Constant.NewUser.userName,
                            text: $name,
                            validate: { newUserController.validateUserInputs($0) },
                            errorMessage: Constant.NewUser.nameMissing
                        )
                    }
                    VStack(spacing: 6) {
                        ValidatedTextField(
                            title: Constant.NewUser.userEmail,
                            text: $email,
                            validate: { newUserController.validateUserInputs($0) },
                            errorMessage: Constant.NewUser.emailMissing
                        )
                        .keyboardType(.emailAddress)
                    }
                    VStack(spacing: 6) {
                        ValidatedSecureFieldText(
                            title: Constant.NewUser.userPin,
                            text: $pinCode,
                            validate: { newUserController.validateUserInputs($0) },
                            errorMessage: Constant.NewUser.pinMissing
                        )
                    }
                    VStack(spacing: 6) {
                        ValidatedTextField(
                            title: Constant.NewUser.userCategory,
                            text: $categoryInput,
                            validate: { newUserController.validateUserInputs($0) },
                            errorMessage: Constant.NewUser.roleMissing
                        )
                    }
                    Button {
                        guard let category = parseCategory(from: categoryInput) else {
                            alertMessage = Constant.Message.Error.wrongCategoryChoosen
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
                        alertMessage = Constant.Message.Success.userRegistered
                        showAlert = true
                        newUserController.registerNewUser(newUser)
                    } label: {
                        ButtomShape(title: Constant.NewUser.addUserButtom)
                    }
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1 : 0.6)
                    
                    Button {
                        dismiss()
                    } label: {
                        ButtomShape(title: Constant.NewUser.cancelUserButtom)
                    }
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1 : 0.6)
                }
                .padding(.bottom, 40)
            }
        }
        .alert(Constant.Message.Success.userRegistered, isPresented: $showAlert) {
            Button(Constant.Message.AlertDialog.ok) { dismiss() }
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
    
    private var showNameError: Bool {
        nameEdited && !newUserController.validateUserInputs(name)
    }
    
    private var isFormValid: Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !pinCode.isEmpty &&
        !categoryInput.isEmpty
    }
}


