//
//  ServerTableCardView.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/8/25.
//

import SwiftUI

struct ServerTableRow: View {
    let number: Int
    let status: String
    let total: Double
    let seatedTime: String

    @State private var showDetails = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                withAnimation {
                    showDetails.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "table")
                        .foregroundColor(.brown)
                    Text("\(number)")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(showDetails ? 90 : 0))
                        .foregroundColor(.gray)
                        .animation(.easeInOut, value: showDetails)
                }
            }

            if showDetails {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Circle()
                            .fill(color(for: status))
                            .frame(width: 8, height: 8)
                        Text(status)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Text("\(ViewConstants.ServerView.total): \(total.formatted(.currency(code: "USD")))")
                        .font(.subheadline)
                    
                    Text(seatedTime)
                        .font(.caption)
                        .foregroundColor(.secondary)

                }
                .padding(.leading, 28)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(12)
        .shadow(radius: 1)
    }

    private func color(for status: String) -> Color {
        switch status.lowercased() {
        case "preparing": return .orange
        case "delivered": return .green
        case "in progress": return .blue
        default: return .gray
        }
    }
}

#Preview {
    ServerTableRow(
        number: 5,
        status: "Preparing",
        total: 78.50,
        seatedTime: "12 min"
    )
}
