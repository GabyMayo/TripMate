import SwiftUI

struct TripCalendarView: View {
    @State private var selectedDate = Date()
    @State private var energyData: [String: Double] = [:]
    @State private var activityData: [String: Double] = [:]
    @State private var notes: [String: [String]] = [:]
    @State private var newNote: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            let dateKey = formattedDate(selectedDate)
            
            // Energy
            HStack {
                Text("Energy:")
                TextField("Value", value: Binding(
                    get: { energyData[dateKey] ?? 0 },
                    set: { energyData[dateKey] = $0 }
                ), formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            // Activity
            HStack {
                Text("Activity:")
                TextField("Value", value: Binding(
                    get: { activityData[dateKey] ?? 0 },
                    set: { activityData[dateKey] = $0 }
                ), formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            // Notes
            VStack(alignment: .leading) {
                Text("Notes:")
                    .font(.headline)
                HStack {
                    TextField("New note", text: $newNote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        if !newNote.isEmpty {
                            notes[dateKey, default: []].append(newNote)
                            newNote = ""
                        }
                    }
                }
                ForEach(Array(notes[dateKey, default: []].enumerated()), id: \.offset) { index, note in
                    HStack {
                        Text(note)
                        Spacer()
                        Button { notes[dateKey]?.remove(at: index) } label: {
                            Image(systemName: "trash").foregroundColor(.red)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .background(Color(red: 0.5, green: 0.78, blue: 0.8))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
