//
//  MainScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/9/25.
//

import SwiftUI

struct MainScreen: View {

    let user: User
    let databaseManager: DatabaseManaging

    @State private var isSidebarShowing = false
    @State private var showAnalysisScreen = false
    @State private var showClockInScreen = false
    @State private var showScheduleScreen = false
    @State private var showFloorMapScreen = false
    @State private var showShoppingListScreen = false
    @State private var showPaymentScreen = false

    init(user: User, databaseManager: DatabaseManaging) {
        self.user = user
        self.databaseManager = databaseManager
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.976, blue: 0.769),
                        Color(red: 0.773, green: 0.882, blue: 0.647)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    HStack(alignment: .center) {
                        Button(action: {
                            withAnimation {
                                isSidebarShowing.toggle()
                            }
                        }) {
                            Image(systemName: "sidebar.left")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                        }

                        Spacer()

                        Text("Main Content")
                            .font(.headline)
                            .padding()

                        Spacer()
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Shift Today")
                            .font(.headline)

                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start: 5:00 PM")
                                Text("End: 10:00 PM")
                            }

                            Spacer()

                            VStack(alignment: .leading) {
                                Text("Duration: 5h")
                                Text("Estimated Pay: $150")
                            }
                        }
                        .font(.subheadline)

                        HStack {
                            Button(action: {
                                showClockInScreen = true
                            }) {
                                Text("Clock In")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green.opacity(0.7))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                // action to offer shift
                            }) {
                                Text("Offer Shift")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange.opacity(0.7))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Spacer()
                }

                if isSidebarShowing {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isSidebarShowing = false
                            }
                        }
                }

                VStack(alignment: .leading, spacing: 20) {
                    Button(action: {
                        showAnalysisScreen = true
                        isSidebarShowing = false
                    }) {
                        Label("Analysis", systemImage: "chart.bar")
                    }

                    Button(action: {
                        showClockInScreen = true
                        isSidebarShowing = false
                    }) {
                        Label("Clock In", systemImage: "clock")
                    }

                    Button(action: {
                        showScheduleScreen = true
                        isSidebarShowing = false
                    }) {
                        Label("Schedule", systemImage: "calendar")
                    }

                    Button(action: {
                        showFloorMapScreen = true
                        isSidebarShowing = false
                    }) {
                        Label("Tables", systemImage: "square.grid.3x3.middle.filled")
                    }

                    Button(action: {
                        showShoppingListScreen = true
                        isSidebarShowing = false
                    }) {
                        Label("Shopping List", systemImage: "cart")
                    }
                    
                    Button(action: {
                        showPaymentScreen = true
                        isSidebarShowing = false
                    }) {
                        Label("Payment", systemImage: "dollarsign.circle.fill")
                    }

                    Spacer()
                }
                .frame(width: 250)
                .padding(.top, 80)
                .padding(.horizontal)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.953, green: 0.937, blue: 0.718),
                            Color(red: 0.741, green: 0.792, blue: 0.604)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .opacity(0.95)
                )
                .offset(x: isSidebarShowing ? 0 : -300)
                .animation(.easeInOut(duration: 0.3), value: isSidebarShowing)
            }
            .navigationDestination(isPresented: $showAnalysisScreen) {
                AnalysisScreen(user: user)
            }
            .navigationDestination(isPresented: $showClockInScreen) {
                ClockInScreen(userName: user.name)
            }
            .navigationDestination(isPresented: $showScheduleScreen) {
                ScheduleScreen()
            }
            .navigationDestination(isPresented: $showFloorMapScreen) {
                FloorMapScreen(databaseManager: databaseManager, user: user)
            }
            .navigationDestination(isPresented: $showShoppingListScreen) {
                ShoppingListScreen()
            }
            .navigationDestination(isPresented: $showPaymentScreen) {
                PaymentScreen(userName: user.name)
            }
        }
    }
}

