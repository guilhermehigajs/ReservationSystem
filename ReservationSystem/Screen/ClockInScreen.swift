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
            BackgroundGradient(colors: [
                Color(red: 0.996, green: 0.898, blue: 0.635),
                Color(red: 0.753, green: 0.686, blue: 0.486)
            ])

            VStack {
                Spacer()

                VStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("Hello, \(userName)")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.8))

                        Text(Constant.ClockInController.shiftControl)
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
                                    Label(Constant.ClockInController.returnBreak, systemImage: Constant.ClockInController.returnBreakImage)
                                }
                                .buttonStyle(ShiftButtonStyle())
                            } else {
                                Button {
                                    simulateAction(.breakTime)
                                } label: {
                                    Label(Constant.ClockInController.breakShift, systemImage: Constant.ClockInController.breakShiftImage)
                                }
                                .buttonStyle(ShiftButtonStyle())
                            }

                            Button {
                                simulateAction(.endShift)
                            } label: {
                                Label(Constant.ClockInController.endShift, systemImage: Constant.ClockInController.endShiftImage)
                            }
                            .buttonStyle(ShiftButtonStyle())
                        }
                    } else {
                        Button {
                            simulateAction(.clockIn)
                        } label: {
                            Label(Constant.ClockInController.clockIn, systemImage: Constant.ClockInController.clockInImage)
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
                confirmationMessage = Constant.ClockInController.clockInCompleted
            case .breakTime:
                isOnBreak = true
                confirmationMessage = Constant.ClockInController.breakStarted
            case .returnFromBreak:
                isOnBreak = false
                confirmationMessage = Constant.ClockInController.returnBreakCompleted
            case .endShift:
                hasClockedIn = false
                isOnBreak = false
                confirmationMessage = Constant.ClockInController.shiftEnded
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

#Preview {
    ClockInScreen(userName: "Guilherme")
}
