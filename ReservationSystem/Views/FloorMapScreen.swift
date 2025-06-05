import SwiftUI

struct FloorMapScreen: View {
    
    @State private var tables: [Table] = []
    @State private var selectedLevelLocal: Int? = nil
    @StateObject private var floorMapController: FloorMapController
    
    init(databaseManager: DatabaseManaging) {
        _floorMapController = StateObject(wrappedValue: FloorMapController(database: databaseManager))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .top, spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Select the floor")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Picker("", selection: $selectedLevelLocal) {
                        Text("Level").tag(nil as Int?)
                        ForEach(floorMapController.availableLevels, id: \.self) { level in
                            Text("\(level)").tag(level as Int?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedLevelLocal) {
                        floorMapController.selectedLevel = selectedLevelLocal
                        floorMapController.selectedOutsideArea = nil
                    }
                }
                VStack(alignment: .leading) {
                    Text("Select the area")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Picker("", selection: $floorMapController.selectedOutsideArea) {
                        Text("Inside").tag(false as Bool?)
                        
                        if let selectedLevel = selectedLevelLocal,
                           floorMapController.floors.contains(where: { $0.number == selectedLevel && $0.outsideArea }) {
                            Text("Outside").tag(true as Bool?)
                        }
                    }
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
            .padding(.horizontal)

            ZStack {
                ForEach($tables, id: \.id) { $table in
                    TableView(table: $table)
                }
            }
            .background(Color.gray.opacity(0.2))
        }
        .onAppear {
            floorMapController.loadFloorInf()
        }
    }
}

#Preview {
    FloorMapScreen(databaseManager: DatabaseManagerImp())
}
