//
//  NewUserController.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/12/25.
//

import Foundation
import UIKit

class NewUserController: ObservableObject {
    private static let TAG = ControllerConstants.NewUser.name
    
    private var database: DatabaseManaging
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var pinCode: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var jobFunctions: [String] = []
    @Published var categoryInput: String = ""
    @Published var profileImage: UIImage? = nil
    @Published var isLoadingFunctions: Bool = false
    
    init(database: DatabaseManaging) {
        self.database = database
    }
    
    func registerNewUser(_ user: User) {
        database.addNewUser(user)
    }
    
    func validateUserInputs(_ input: String) -> Bool {
        return !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String {
        try await database.uploadProfileImage(image, userId: userId)
    }
    
    func getJobFunctions() {
        guard jobFunctions.isEmpty else { return }
        isLoadingFunctions = true
        database.getJobFunctions { [weak self] functions in
            guard let self = self else { return }
            self.jobFunctions = functions.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
            self.isLoadingFunctions = false
        }
    }
    
    func isAnyInputEmpty() -> Bool {
        !name.isEmpty &&
        !email.isEmpty &&
        !pinCode.isEmpty &&
        !categoryInput.isEmpty
    }
    
    func generateNewUser() -> User {
        let fallbackRaw = 1
        let raw = Int(categoryInput) ?? fallbackRaw
        let category = EmployeeCategory(rawValue: raw) ?? EmployeeCategory(rawValue: fallbackRaw)!
        
        return User(
            id: UUID().uuidString,
            name: name,
            email: email,
            pinCode: pinCode,
            employeeCategory: category)
    }
    
    func handleAddUserTapped() {
        showAlert = true
        alertMessage = Constant.Message.Success.userRegistered
        registerNewUser(generateNewUser())
    }
}
