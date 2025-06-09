//
//  AnalysisScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/7/25.
//

import SwiftUI

struct AnalysisScreen: View {
    @StateObject private var analysisController: AnalysisController

    init(user: User) {
        _analysisController = StateObject(wrappedValue: AnalysisController(user: user))
    }

    var body: some View {
//        VStack {
//            Text(Constant.AnalysisController.title)
//                .font(.title)
//                .padding()
//
//            contentView
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        ServerView()
//            .navigationBarTitleDisplayMode(.inline)
        ManagerView()
            .navigationBarTitleDisplayMode(.inline)
        
    }

    @ViewBuilder
    private var contentView: some View {
        switch analysisController.category {
        case .server:
            ServerView()
        case .manager, .generalManager:
            ManagerView()
        case .host:
            Text(Constant.Message.Error.unsupportedCategory)
        }
    }
}

#Preview {
    let mockUser = User(id: "1", name: "guilherme", email: "guilherme@gmail.com", pinCode: "1111", employeeCategory: .generalManager)
    AnalysisScreen(user: mockUser)
}
