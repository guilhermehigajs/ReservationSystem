//
//  PaymentScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/9/25.
//

import SwiftUI
import Charts

struct DailyPayment: Identifiable {
    let id = UUID()
    let day: String
    let expectedEarnings: Double
    let actualEarnings: Double
    let expectedHours: Double
    let actualHours: Double
}

struct PaymentScreen: View {
    let userName: String

    let data: [DailyPayment] = [
        .init(day: "Mon", expectedEarnings: 120, actualEarnings: 130, expectedHours: 5, actualHours: 5),
        .init(day: "Tue", expectedEarnings: 180, actualEarnings: 150, expectedHours: 6, actualHours: 5),
        .init(day: "Wed", expectedEarnings: 0, actualEarnings: 0, expectedHours: 0, actualHours: 0),
        .init(day: "Thu", expectedEarnings: 200, actualEarnings: 210, expectedHours: 6, actualHours: 6),
        .init(day: "Fri", expectedEarnings: 250, actualEarnings: 260, expectedHours: 7, actualHours: 7),
        .init(day: "Sat", expectedEarnings: 300, actualEarnings: 280, expectedHours: 8, actualHours: 7),
        .init(day: "Sun", expectedEarnings: 100, actualEarnings: 90, expectedHours: 4, actualHours: 4)
    ]

    var totalExpected: Double {
        data.map { $0.expectedEarnings }.reduce(0, +)
    }

    var totalActual: Double {
        data.map { $0.actualEarnings }.reduce(0, +)
    }

    var totalExpectedHours: Double {
        data.map { $0.expectedHours }.reduce(0, +)
    }

    var totalActualHours: Double {
        data.map { $0.actualHours }.reduce(0, +)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer().frame(height: 10)

            HStack {
                Spacer()
                Text(Constant.PaymentController.title)
                    .font(.title2)
                    .bold()
                Spacer()
            }

            Text("Hello, \(userName) 👋")
                .font(.headline)
                .padding(.horizontal)

            Text(Constant.PaymentController.weeklyPerformace)
                .font(.subheadline)
                .padding(.horizontal)

            Chart {
                ForEach(data) { entry in
                    BarMark(
                        x: .value(Constant.PaymentController.day, entry.day),
                        y: .value(Constant.PaymentController.expected, entry.expectedEarnings)
                    )
                    .foregroundStyle(Color.green.opacity(0.6))
                    .position(by: .value(Constant.PaymentController.type, Constant.PaymentController.expected))

                    BarMark(
                        x: .value(Constant.PaymentController.day, entry.day),
                        y: .value(Constant.PaymentController.actual, entry.actualEarnings)
                    )
                    .foregroundStyle(Color.blue.opacity(0.6))
                    .position(by: .value(Constant.PaymentController.type, Constant.PaymentController.actual))
                }
            }
            .frame(height: 220)
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text(Constant.PaymentController.totalExpected + "\(String(format: "%.2f", totalExpected)) • \(String(format: "%.1f", totalExpectedHours))h")
                Text(Constant.PaymentController.actualTotal + "\(String(format: "%.2f", totalActual)) • \(String(format: "%.1f", totalActualHours))h")
            }
            .font(.subheadline)
            .padding(.horizontal)

            Spacer()
        }
        .background(
            BackgroundGradient(colors: [
                Color(red: 1.0, green: 0.976, blue: 0.769),
                Color(red: 0.773, green: 0.882, blue: 0.647)
            ])
        )
    }
}

#Preview {
    PaymentScreen(userName: "Guilherme")
}

