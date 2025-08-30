import SwiftUI

struct AccessScreen: View {
    
    let databaseManager: DatabaseManaging
    private let accessController: AccessController

    @State var user: User?
    @State private var firstDigit: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false
    @State private var isRegistering = false

    init(databaseManager: DatabaseManaging) {
        self.databaseManager = databaseManager
        self.accessController = AccessController(database: databaseManager)
    }
    
    var body: some View {
        ZStack {
            BackgroundGradient(colors: [
                Color(red: 0.996, green: 0.898, blue: 0.635),
                Color(red: 0.753, green: 0.686, blue: 0.486)
            ])

            VStack(spacing: 20) {
                Image(Constant.Application.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220, height: 220)
                    .padding(.top, -40)

                TextField(Constant.Message.enterCode, text: $firstDigit)
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)

                VStack(spacing: 10) {
                    Button(action: {
                        accessController.checkAccess(firstDigit) { isValid, returnedUser in
                            if isValid, let userFromDatabase = returnedUser {
                                firstDigit = ""
                                isLoggedIn = true
                                user = userFromDatabase
                            } else {
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
                            .background(Color(red: 1.0, green: 0.718, blue: 0.302))
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                    }
                    
                    Button(action: {
                        isRegistering = true
                    }) {
                        Text(ControllerConstants.Access.addNewUserButtomMessage)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 1.0, green: 0.718, blue: 0.302))
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                    }
                }

                Text(Constant.Application.appVersion)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    .scaleEffect(1.2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 60)
        }
        .alert(Constant.Message.Error.credentialsNotRecognized, isPresented: $showAlert) {
            Button(Constant.Message.AlertDialog.ok, role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .navigationDestination(isPresented: $isLoggedIn) {
            if let validUser = user {
                MainScreen(user: validUser, databaseManager: databaseManager)
            } else {
                Text(alertMessage)
            }
        }
        .navigationDestination(isPresented: $isRegistering) {
            NewUserScreen(databaseManager: databaseManager)
        }
    }
}

#Preview {
    AccessScreen(databaseManager: DatabaseManagerImp())
}

