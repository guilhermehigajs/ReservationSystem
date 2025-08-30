//
//  NewUserScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/12/25.
//

import SwiftUI

struct NewUserScreen: View {
    
    let databaseManager: DatabaseManaging
    @StateObject private var mController: NewUserController
    
    @State private var nameEdited = false
    @State private var nameError: String?
    
    @Environment(\.dismiss) private var dismiss
    
    init(databaseManager: DatabaseManaging) {
        self.databaseManager = databaseManager
        _mController = StateObject(wrappedValue: NewUserController(database: databaseManager))
    }
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            ScrollView {
                VStack(spacing: 16) {
                    Text(ViewConstants.NewUserView.title)
                        .font(.title2)
                        .bold()
                        .padding(.top, 12)
                    
                    ProfilePicturePicker(
                        image: $mController.profileImage,
                        title: ViewConstants.ProfilePicturePicker.title,
                        size: 120,
                        allowsRemoval: true
                    )
                    .padding(.top, 4)
                    
                    VStack(spacing: 6) {
                        ValidatedTextField(
                            title: ViewConstants.NewUserView.userName,
                            text: $mController.name,
                            validate: { mController.validateUserInputs($0) },
                            errorMessage: ViewConstants.NewUserView.nameMissing
                        )
                    }
                    VStack(spacing: 6) {
                        ValidatedTextField(
                            title: ViewConstants.NewUserView.userEmail,
                            text: $mController.email,
                            validate: { mController.validateUserInputs($0) },
                            errorMessage: ViewConstants.NewUserView.emailMissing
                        )
                        .keyboardType(.emailAddress)
                    }
                    VStack(spacing: 6) {
                        ValidatedSecureFieldText(
                            title: ViewConstants.NewUserView.userPin,
                            text: $mController.pinCode,
                            validate: { mController.validateUserInputs($0) },
                            errorMessage: ViewConstants.NewUserView.pinMissing
                        )
                    }
                    VStack(spacing: 6) {
                        Picker(selection: $mController.categoryInput, label:
                                ValidatedTextField(
                                    title: ViewConstants.NewUserView.userCategory,
                                    text: $mController.categoryInput,
                                    validate: { mController.validateUserInputs($0) },
                                    errorMessage: ViewConstants.NewUserView.roleMissing
                                )
                                    .disabled(true)
                                    .overlay(alignment: .trailing) {
                                        HStack(spacing: 6) {
                                            if mController.isLoadingFunctions {
                                                ProgressView()
                                                    .scaleEffect(0.8)
                                            }
                                            Image(systemName: Constant.Image.NewUser.icon)
                                                .font(.footnote)
                                                .opacity(mController.jobFunctions.isEmpty ? 0.3 : 1)
                                        }
                                        .padding(.trailing, 12)
                                    }
                        ) {
                            if mController.categoryInput.isEmpty {
                                Text(DatabaseConstants.JobFunctions.selectJobFunction)
                                    .tag("")
                            }
                            ForEach(mController.jobFunctions, id: \.self) { function in
                                Text(function).tag(function)
                            }
                        }
                        .pickerStyle(.menu)
                        .disabled(mController.jobFunctions.isEmpty || mController.isLoadingFunctions)
                    }
                    Button(action: mController.handleAddUserTapped) {
                        ButtomShape(title: ViewConstants.NewUserView.addUserButtom)
                    }
                    .disabled(!mController.isAnyInputEmpty())
                    .opacity(mController.isAnyInputEmpty() ? 1 : 0.6)
                    
                    Button {
                        dismiss()
                    } label: {
                        ButtomShape(title: ViewConstants.NewUserView.cancelUserButtom)
                    }
                    .disabled(!mController.isAnyInputEmpty())
                    .opacity(mController.isAnyInputEmpty() ? 1 : 0.6)
                }
                .padding(.bottom, 40)
                .onAppear(perform: mController.getJobFunctions)
            }
        }
        .alert(Constant.Message.Success.userRegistered, isPresented: $mController.showAlert) {
            Button(Constant.Message.AlertDialog.ok) { dismiss() }
        } message: {
            Text(mController.alertMessage)
        }
    }
}


