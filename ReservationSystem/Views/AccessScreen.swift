import SwiftUI

struct AccessScreen: View {
    
    let databaseManager: DatabaseManaging
    private let accessController: AccessController

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
                Image("ReservationSystemLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                TextField("", text: $firstDigit)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 160, height: 40)
                
                Button(action: {
                    accessController.checkAccess(firstDigit) { isValid in
                        if isValid {
                            print("logged in successfully")
                            firstDigit = ""
                            isLoggedIn = true
                        } else {
                            print("Failed to validate credentials")
                            alertMessage = "Please, contact administrator."
                            showAlert = true
                        }
                    }
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
                
                Text("Version 1.0")
                    .font(.caption)
            }
            .alert("Credentials not recognized", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                FloorMapScreen(databaseManager: databaseManager)
            }
        }
    }
}

#Preview {
    AccessScreen(databaseManager: DatabaseManagerImp())
}
