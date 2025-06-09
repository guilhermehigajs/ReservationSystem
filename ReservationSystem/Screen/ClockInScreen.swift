//
//  ClockInScreen.swiftUi
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/8/25.
//

import SwiftUI

struct ClockInScreen: View {

    let userName: String
    @AppStorage("hasClockedIn") private var hasClockedIn: Bool = false
    @AppStorage("isOnBreak") private var isOnBreak: Bool = false

    @State private var pendingAction: ShiftAction? = nil
    @State private var showConfirmationText = false
    @State private var confirmationMessage = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.996, green: 0.898, blue: 0.635),
                    Color(red: 0.753, green: 0.686, blue: 0.486)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("Hello, \(userName)")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.8))

                        Text("Shift Control")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                    }

                    Divider()

                    if hasClockedIn {
                        VStack(spacing: 16) {
                            if isOnBreak {
                                Button {
                                    simulateAction(.returnFromBreak)
                                } label: {
                                    Label("Return from Break", systemImage: "play.circle")
                                }
                                .buttonStyle(ShiftButtonStyle())
                            } else {
                                Button {
                                    simulateAction(.breakTime)
                                } label: {
                                    Label("Break", systemImage: "pause.circle")
                                }
                                .buttonStyle(ShiftButtonStyle())
                            }

                            Button {
                                simulateAction(.endShift)
                            } label: {
                                Label("End Shift", systemImage: "stop.circle")
                            }
                            .buttonStyle(ShiftButtonStyle())
                        }
                    } else {
                        Button {
                            simulateAction(.clockIn)
                        } label: {
                            Label("Clock In", systemImage: "clock")
                        }
                        .buttonStyle(ShiftButtonStyle())
                    }

                    if showConfirmationText {
                        Text(confirmationMessage)
                            .font(.footnote)
                            .foregroundColor(.green)
                            .transition(.opacity)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 32)

                Spacer()
            }
        }
    }

    func simulateAction(_ action: ShiftAction) {
        withAnimation {
            switch action {
            case .clockIn:
                hasClockedIn = true
                confirmationMessage = "✅ Clock In completed"
            case .breakTime:
                isOnBreak = true
                confirmationMessage = "☕ Break started"
            case .returnFromBreak:
                isOnBreak = false
                confirmationMessage = "▶️ Returned from break"
            case .endShift:
                hasClockedIn = false
                isOnBreak = false
                confirmationMessage = "🔚 Shift ended"
            }
            showConfirmationText = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                showConfirmationText = false
            }
        }
    }
}

enum ShiftAction {
    case clockIn, breakTime, returnFromBreak, endShift
}

struct ShiftButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(configuration.isPressed ? 0.1 : 0.05))
            .foregroundColor(.black)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
            )
    }
}

#Preview {
    ClockInScreen(userName: "Guilherme")
}
