//
//  ShiftInformationView.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/11/25.
//

import SwiftUI

struct ShiftInformationView: View {
    let onMenuTap: () -> Void
    let onClockInTap: () -> Void
    let onOfferShiftTap: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        onMenuTap()
                    }
                }) {
                    Image(systemName: Constant.MainController.menuLeft)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                }
                
                Spacer()
                
                Text(Constant.Application.appName)
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(Constant.MainController.todayShift)
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
                        onClockInTap()
                    }) {
                        Text(Constant.ClockInController.clockIn)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        onOfferShiftTap()
                    }) {
                        Text(Constant.MainController.offerShift)
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
        }
    }
}

