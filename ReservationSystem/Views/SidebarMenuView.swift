//
//  SidebarMenuView.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/11/25.
//

import SwiftUI

struct SidebarMenuItem {
    let title: String
    let iconName: String
    let action: () -> Void
}

struct SidebarMenuView: View {
    let items: [SidebarMenuItem]
    let isVisible: Bool
    let onBackgroundTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isVisible {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            onBackgroundTap()
                        }
                    }
            }
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    Button(action: {
                        item.action()
                        onBackgroundTap()
                    }) {
                        Label(item.title, systemImage: item.iconName)
                    }
                }
                
                Spacer()
            }
            .frame(width: 250)
            .padding(.top, 80)
            .padding(.horizontal)
            .background(
                BackgroundGradient(colors: [
                    Color(red: 0.953, green: 0.937, blue: 0.718),
                    Color(red: 0.741, green: 0.792, blue: 0.604)
                ])
                .opacity(0.95)
            )
            .offset(x: isVisible ? 0 : -300)
            .animation(.easeInOut(duration: 0.3), value: isVisible)
        }
    }
}
