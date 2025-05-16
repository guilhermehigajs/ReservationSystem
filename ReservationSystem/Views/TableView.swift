//
//  TableView.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import SwiftUI

struct TableView: View {
    @Binding var table: Table
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(colorForStatus(table.status))
                .frame(width: 80, height: 80)
                .overlay(
                    Text("\(table.number)")
                        .foregroundColor(.white)
                        .bold()
                )
        }
        .position(x: table.position.x + dragOffset.width,
                  y: table.position.y + dragOffset.height)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation
                }
                .onEnded { value in
                    table.position.x += value.translation.width
                    table.position.y += value.translation.height
                }
        )
    }
    
    private func colorForStatus(_ status: TableStatus) -> Color {
        switch status {
        case .available: return .green
        case .occupied: return .red
        case .reserved: return .yellow
        case .bussing: return .orange
        case .orderCheck: return .blue
        }
    }
}


#Preview {
    TablePreviewWrapper()
}

struct TablePreviewWrapper: View {
    @State var table = Table(
        id: UUID(),
        capacity: 4,
        number: 54,
        status: .available,
        position: CGPoint(x: 100, y: 100)
    )
    
    var body: some View {
        TableView(table: $table)
    }
}

