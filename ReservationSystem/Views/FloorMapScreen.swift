import SwiftUI

struct FloorMapScreen: View {
    
    @StateObject private var floorMapController: FloorMapController

    
    @State private var tables: [Table] = []
    @State private var selectedLevelLocal: Int? = nil
    
    init(databaseManager: DatabaseManaging) {
        _floorMapController = StateObject(wrappedValue: FloorMapController(database: databaseManager))
}
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Selecione o andar", selection: $selectedLevelLocal) {
                Text("Escolha...").tag(nil as Int?)
                ForEach(floorMapController.availableLevels, id: \.self) { level in
                    Text("\(level)").tag(level as Int?)
                }
            }
            .pickerStyle(MenuPickerStyle())
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
            floorMapController.fetchTables(0, false) { fetchedTables in
                self.tables = fetchedTables
            }
        }
    }
}

#Preview {
    FloorMapScreen(databaseManager: DatabaseManagerImp())
}
