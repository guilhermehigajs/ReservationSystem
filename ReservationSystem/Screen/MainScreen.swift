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
    let mainController : MainController
    
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
        self.mainController = MainController(user: user, database: databaseManager)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            BackgroundGradient(colors: [
                Color(red: 1.0, green: 0.976, blue: 0.769),
                Color(red: 0.773, green: 0.882, blue: 0.647)
            ])
            .ignoresSafeArea()
            
            VStack {
                ShiftInformationView(
                    onMenuTap: { isSidebarShowing.toggle() },
                    onClockInTap: { showClockInScreen = true },
                    onOfferShiftTap: { /* swap shift functionality */ }
                )
                Spacer()
            }
            
            if isSidebarShowing {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isSidebarShowing = false
                        }
                    }
            }
            
            SidebarMenuView(
                items: mainController.menuOptions.map { option in
                    SidebarMenuItem(
                        title: mainController.localizedTitle(for: option),
                        iconName: mainController.iconName(for: option),
                        action: {
                            handleMenuOption(option)
                        }
                    )
                },
                isVisible: isSidebarShowing,
                onBackgroundTap: {
                    isSidebarShowing = false
                }
            )
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
        .navigationDestination(isPresented: $showPaymentScreen) {
            PaymentScreen(userName: user.name)
        }
    }
    
    private func handleMenuOption(_ option: MenuOption) {
        mainController.saveLastMenuOption(option)
        
        switch option {
        case .analysis:
            showAnalysisScreen = true
        case .clockIn:
            showClockInScreen = true
        case .schedule:
            showScheduleScreen = true
        case .floorMap:
            showFloorMapScreen = true
        case .payment:
            showPaymentScreen = true
        }
    }
}

