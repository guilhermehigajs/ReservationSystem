import SwiftUI

struct AccessScreen: View {
    
    let databaseManager: DatabaseManaging
    private let accessController: AccessController

    @State var user: User?
    @State private var firstDigit: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false


    init(databaseManager: DatabaseManaging) {
        self.databaseManager = databaseManager
        self.accessController = AccessController(database: databaseManager)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(Constant.Application.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                TextField("", text: $firstDigit)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 160, height: 40)
                
                Button(action: {
                    accessController.checkAccess(firstDigit) { isValid, returnedUser in
                        if isValid, let userFromDatabase = returnedUser {
                            print(Constant.Message.Success.loggedInSuccessfully)
                            firstDigit = ""
                            isLoggedIn = true
                            user = userFromDatabase
                        } else {
                            print(Constant.Message.Error.failedValidateCredentials)
                            alertMessage = Constant.Message.AlertDialog.contactAdmin
                            showAlert = true
                        }
                    }

                }) {
                    Text(Constant.Message.AlertDialog.signIn)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                }
                
                Text(Constant.Application.appVersion)
                    .font(.caption)
            }
            .alert(Constant.Message.Error.credentialsNotRecognized, isPresented: $showAlert) {
                Button(Constant.Message.AlertDialog.ok, role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                if let validUser = user {
                    FloorMapScreen(databaseManager: databaseManager, user: validUser)
                } else {
                    Text(alertMessage)
                }
            }

        }
    }
}

#Preview {
    AccessScreen(databaseManager: DatabaseManagerImp())
}
