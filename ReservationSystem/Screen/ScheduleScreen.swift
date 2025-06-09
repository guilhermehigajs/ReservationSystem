import SwiftUI

struct ScheduleScreen: View {
    @State private var currentWeek: [Date] = Date().startOfWeek().datesForWeek()
    @State private var selectedDate: Date = Date()

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

            VStack(alignment: .leading, spacing: 16) {
                Text(selectedDate.formatted(.dateTime.month(.wide)))
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(currentWeek, id: \.self) { date in
                            let hasShift = mockShifts[date.onlyDate()] != nil

                            VStack(spacing: 6) {
                                Text(date.formatted(.dateTime.weekday(.abbreviated)))
                                    .font(.subheadline)
                                Text(date.formatted(.dateTime.day()))
                                    .font(.title3)
                                    .bold()
                            }
                            .frame(width: 70, height: 80)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(date.isSameDay(as: selectedDate) ? Color.white.opacity(0.85) : Color.white.opacity(0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(hasShift ? Color.green.opacity(0.8) : .clear, lineWidth: 2)
                                    )
                            )
                            .onTapGesture {
                                selectedDate = date
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(currentWeek, id: \.self) { date in
                            let shift = mockShifts[date.onlyDate()]
                            let role = shift?.role ?? "Off"
                            let hasShift = shift != nil

                            DisclosureGroup {
                                if let shift = shift {
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading, spacing: 6) {
                                                HStack {
                                                    Image(systemName: "clock.fill").foregroundColor(.blue)
                                                    Text("\(shift.startTime) - \(shift.endTime)")
                                                }

                                                HStack {
                                                    Image(systemName: "dollarsign.circle.fill").foregroundColor(.green)
                                                    Text("$\(shift.estimatedPay, specifier: "%.2f")")
                                                }

                                                HStack {
                                                    Image(systemName: "hourglass.bottomhalf.filled").foregroundColor(.orange)
                                                    Text("\(shift.hoursWorked, specifier: "%.1f") hours")
                                                }
                                            }

                                            Spacer()
                                        }
                                    }
                                    .padding(.top, 4)
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(date.formatted(.dateTime.weekday().day()))
                                        .font(.headline)

                                    if hasShift {
                                        Text("Scheduled Shift — \(role)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    } else {
                                        Text("Day off")
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

extension Date {
    func startOfWeek() -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }

    func datesForWeek() -> [Date] {
        let start = self.startOfWeek()
        return (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: start) }
    }

    func onlyDate() -> Date {
        Calendar.current.startOfDay(for: self)
    }

    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }
}

struct Shift {
    var startTime: String
    var endTime: String
    var estimatedPay: Double
    var hoursWorked: Double
    var role: String
}

let mockShifts: [Date: Shift] = [
    Date().onlyDate(): Shift(startTime: "10:00", endTime: "18:00", estimatedPay: 120.0, hoursWorked: 8, role: "Server"),
    Calendar.current.date(byAdding: .day, value: 2, to: Date())!.onlyDate(): Shift(startTime: "12:00", endTime: "20:00", estimatedPay: 135.0, hoursWorked: 8, role: "Bartender")
]

#Preview {
    ScheduleScreen()
}
