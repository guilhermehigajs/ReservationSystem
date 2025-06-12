import SwiftUI
import Charts

struct HourlyRevenue: Identifiable {
    let id = UUID()
    let hour: Int
    let revenue: Double
}

struct Server: Identifiable {
    let id = UUID()
    let name: String
    let tables: Int
    let totalRevenue: Double
    let tips: Double
}

struct ManagerView: View {
    let hourlyData: [HourlyRevenue] = [
        .init(hour: 11, revenue: 120.0),
        .init(hour: 12, revenue: 180.0),
        .init(hour: 13, revenue: 220.0),
        .init(hour: 14, revenue: 150.0),
        .init(hour: 15, revenue: 100.0),
        .init(hour: 16, revenue: 190.0),
        .init(hour: 17, revenue: 250.0),
        .init(hour: 18, revenue: 300.0),
        .init(hour: 19, revenue: 400.0)
    ]

    let activeServers: [Server] = [
        .init(name: "Alice", tables: 3, totalRevenue: 850.0, tips: 120.0),
        .init(name: "Bob", tables: 2, totalRevenue: 540.0, tips: 80.0),
        .init(name: "Charlie", tables: 4, totalRevenue: 960.0, tips: 150.0)
    ]

    let completedServers: [Server] = [
        .init(name: "Diana", tables: 5, totalRevenue: 1230.0, tips: 210.0),
        .init(name: "Ethan", tables: 3, totalRevenue: 750.0, tips: 95.0),
        .init(name: "Fiona", tables: 4, totalRevenue: 890.0, tips: 130.0)
    ]

    let upcomingServers: [Server] = [
        .init(name: "George", tables: 0, totalRevenue: 0.0, tips: 0.0),
        .init(name: "Hannah", tables: 0, totalRevenue: 0.0, tips: 0.0),
        .init(name: "Ian", tables: 0, totalRevenue: 0.0, tips: 0.0)
    ]

    @State private var expandedServerID: UUID?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer().frame(height: 10)

                HStack {
                    Spacer()
                    Text("Manager Overview")
                        .font(.title2)
                        .bold()
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Today • June 9, 2025")
                        .font(.headline)

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Staff: 5 / 7")
                            Text("Gross: $3,400.00")
                        }

                        Spacer()

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Guests: 58")
                            Text("Tables: 12 / 18")
                        }
                    }
                    .font(.subheadline)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(16)
                .shadow(radius: 4)
                .padding(.horizontal)

                Text("Revenue – May 2, 2025")
                    .font(.headline)
                    .padding(.horizontal)

                Chart(hourlyData) { data in
                    BarMark(
                        x: .value("Hour", "\(data.hour)h"),
                        y: .value("Revenue", data.revenue)
                    )
                    .foregroundStyle(.green)
                }
                .frame(height: 200)
                .padding(.horizontal)

                serverSection(title: "Active Servers", servers: activeServers)
                serverSection(title: "Completed Shift", servers: completedServers)
                serverSection(title: "Upcoming Servers", servers: upcomingServers)

                Spacer()
            }
        }
        .background(
            BackgroundGradient(colors: [
                Color(red: 1.0, green: 0.976, blue: 0.769),
                Color(red: 0.773, green: 0.882, blue: 0.647)
            ])
        )
    }

    private func serverSection(title: String, servers: [Server]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(servers) { server in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(server.name)
                                        .font(.headline)
                                    Text("Tables: \(server.tables)")
                                        .font(.subheadline)
                                }

                                Spacer()

                                Button(action: {
                                    withAnimation {
                                        expandedServerID = expandedServerID == server.id ? nil : server.id
                                    }
                                }) {
                                    Image(systemName: expandedServerID == server.id ? "chevron.up" : "chevron.down")
                                        .foregroundColor(.gray)
                                }
                            }

                            if expandedServerID == server.id {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Revenue: $\(String(format: "%.2f", server.totalRevenue))")
                                    Text("Tips: $\(String(format: "%.2f", server.tips))")
                                }
                                .font(.footnote)
                                .transition(.opacity.combined(with: .slide))
                            }
                        }
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ManagerView()
}
