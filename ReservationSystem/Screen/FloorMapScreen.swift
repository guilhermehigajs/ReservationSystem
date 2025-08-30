//
//  FloorMapScreen.swiftUi
//  ReservationSystem
//
//  Created by Guilherme Higa on 5/15/25.
//

import SwiftUI

struct FloorMapScreen: View {

    let user: User
    @State private var tables: [Table] = []
    @State private var selectedLevelLocal: Int? = nil
    @StateObject private var floorMapController: FloorMapController

    init(databaseManager: DatabaseManaging, user: User) {
        self.user = user
        _floorMapController = StateObject(wrappedValue: FloorMapController(database: databaseManager, user: user))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundGradient(colors: [
                    Color(red: 1.0, green: 0.976, blue: 0.769),
                    Color(red: 0.773, green: 0.882, blue: 0.647)
                ])

                VStack {
                    ZStack {
                        ForEach($tables, id: \.id) { $table in
                            TableView(table: $table)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    Spacer()

                    HStack(alignment: .top, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text(Constant.Message.selecteFloor)
                                .font(.caption)
                                .foregroundColor(.gray)

                            Picker("", selection: $selectedLevelLocal) {
                                Text(Constant.Message.selectFloorLevel).tag(nil as Int?)
                                ForEach(floorMapController.availableLevels, id: \.self) { level in
                                    Text("\(level)").tag(level as Int?)
                                }
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: selectedLevelLocal) {
                                floorMapController.selectedLevel = selectedLevelLocal
                                floorMapController.selectedOutsideArea = nil
                            }
                        }

                        VStack(alignment: .leading) {
                            Text(Constant.Message.selecteArea)
                                .font(.caption)
                                .foregroundColor(.gray)

                            Picker("", selection: $floorMapController.selectedOutsideArea) {
                                Text(Constant.Message.insideArea).tag(false as Bool?)

                                if let selectedLevel = selectedLevelLocal,
                                   floorMapController.floors.contains(where: { $0.number == selectedLevel && $0.outsideArea }) {
                                    Text(Constant.Message.outsideArea).tag(true as Bool?)
                                }
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: floorMapController.selectedOutsideArea) {
                                if let level = selectedLevelLocal,
                                   let area = floorMapController.selectedOutsideArea {
                                    floorMapController.fetchTables(level, !area) { fetchedTables in
                                        self.tables = fetchedTables
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 20)
                }
            }
            .onAppear {
                floorMapController.loadFloorInf()
            }
            .navigationTitle(ViewConstants.FloorMap.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let mockUser = User(id: "1", name: "guilherme", email: "guilherme@gmail.com", pinCode: "1111", employeeCategory: .generalManager)
    FloorMapScreen(databaseManager: DatabaseManagerImp(), user: mockUser)
}
