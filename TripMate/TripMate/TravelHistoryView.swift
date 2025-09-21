import SwiftUI

struct TravelHistoryView: View {
    @State private var energyData: [String: Double] = [:]
    @State private var activityData: [String: Double] = [:]
    @State private var notes: [String] = []
    @State private var newNote: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Energy Stats
                VStack(alignment: .leading) {
                    Text("Energy Level")
                        .font(.headline)
                    ForEach(energyData.keys.sorted(), id: \.self) { day in
                        HStack {
                            Text("\(day):")
                            TextField("Value", value: Binding(
                                get: { energyData[day] ?? 0 },
                                set: { energyData[day] = $0 }
                            ), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    Button("Add Day") {
                        let day = "Day \(energyData.count + 1)"
                        energyData[day] = 0
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                // Activity Stats
                VStack(alignment: .leading) {
                    Text("Activity Level")
                        .font(.headline)
                    ForEach(activityData.keys.sorted(), id: \.self) { day in
                        HStack {
                            Text("\(day):")
                            TextField("Value", value: Binding(
                                get: { activityData[day] ?? 0 },
                                set: { activityData[day] = $0 }
                            ), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    Button("Add Day") {
                        let day = "Day \(activityData.count + 1)"
                        activityData[day] = 0
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                // Notes Section
                VStack(alignment: .leading) {
                    Text("Travel Notes")
                        .font(.headline)
                    HStack {
                        TextField("New note", text: $newNote)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Add") {
                            if !newNote.isEmpty {
                                notes.append(newNote)
                                newNote = ""
                            }
                        }
                    }
                    ForEach(Array(notes.enumerated()), id: \.offset) { index, note in
                        HStack {
                            Text(note)
                            Spacer()
                            Button(action: { notes.remove(at: index) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .background(Color(red: 0.5, green: 0.78, blue: 0.8))
    }
}
