//
//  ServerView.swiftUi
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//
import SwiftUI

struct ServerView: View {
    var body: some View {
        ZStack {
            BackgroundGradient(colors: [
                Color(red: 1.0, green: 0.976, blue: 0.769),
                Color(red: 0.773, green: 0.882, blue: 0.647)
            ])
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(Constant.ServerView.title)
                        .font(.title2)
                        .bold()
                        .padding(.top, 20)
                        .padding(.horizontal)
                        .foregroundColor(.primary)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .top, spacing: 16) {
                            Image("profile_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 72, height: 72)
                                .clipShape(Circle())
                                .shadow(radius: 4)

                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("John Smith")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.white)

                                    Spacer()

                                    Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.85))
                                }

                                Text("\(Constant.ServerView.total): $480.00")
                                    .font(.subheadline)
                                    .foregroundColor(.white)

                                Text("\(Constant.ServerView.tips): $64.00")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }

                            Spacer()
                        }

                        Text("\(Constant.ServerView.topSpendingTable): 5")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(red: 1.0, green: 0.718, blue: 0.302))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    Text(Constant.ServerView.currentTables)
                        .font(.headline)
                        .padding(.horizontal)

                    let tableData: [(Int, String, Double, String)] = [
                        (2, "Preparing", 78.50, "12 min"),
                        (5, "Delivered", 120.00, "35 min"),
                        (8, "In progress", 42.00, "19 min")
                    ]

                    ForEach(tableData.indices, id: \.self) { index in
                        let table = tableData[index]
                        ServerTableRow(
                            number: table.0,
                            status: table.1,
                            total: table.2,
                            seatedTime: table.3
                        )
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 40)
                }
            }
        }
    }
}
