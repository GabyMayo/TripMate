import SwiftUI

struct VacationDetailView: View {
    @Binding var vacation: Vacation
    @State private var selectedDayIndex = 0
    @State private var newNote = ""
    @State private var newEnergy: Double = 5
    @State private var newActivity: Double = 5

    var body: some View {
        VStack(spacing: 20) {
            Text(vacation.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Day Picker
            Picker("Select Day", selection: $selectedDayIndex) {
                ForEach(0..<vacation.days.count, id: \.self) { index in
                    Text(vacation.days[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            let dayKey = vacation.days[selectedDayIndex]

            ScrollView {
                VStack(spacing: 15) {

                    // Energy Level
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Energy Level (1 = low, 10 = high)")
                            .font(.headline)

                        HStack {
                            Slider(value: Binding(
                                get: { vacation.energyLevels[dayKey]?.last ?? newEnergy },
                                set: { newEnergy = $0 }
                            ), in: 1...10, step: 1)
                            Text("\(Int(vacation.energyLevels[dayKey]?.last ?? newEnergy))")
                                .frame(width: 30)
                        }

                        GradientButton(label: "Add Energy Entry", colors: [Color.blue, Color.purple]) {
                            if vacation.energyLevels[dayKey] != nil {
                                vacation.energyLevels[dayKey]?.append(newEnergy)
                            } else {
                                vacation.energyLevels[dayKey] = [newEnergy]
                            }
                        }

                        if let energies = vacation.energyLevels[dayKey] {
                            ForEach(energies.indices, id: \.self) { index in
                                HStack {
                                    Text("Entry \(index + 1): \(Int(energies[index]))")
                                    Spacer()
                                    GradientButton(label: "🗑️", colors: [Color.red, Color.orange]) {
                                        vacation.energyLevels[dayKey]?.remove(at: index)
                                    }
                                    .frame(width: 70)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                    // Activity Level
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Activity Level (1 = low, 10 = high)")
                            .font(.headline)

                        HStack {
                            Slider(value: Binding(
                                get: { vacation.activityLevels[dayKey]?.last ?? newActivity },
                                set: { newActivity = $0 }
                            ), in: 1...10, step: 1)
                            Text("\(Int(vacation.activityLevels[dayKey]?.last ?? newActivity))")
                                .frame(width: 30)
                        }

                        GradientButton(label: "Add Activity Entry", colors: [Color.green, Color.teal]) {
                            if vacation.activityLevels[dayKey] != nil {
                                vacation.activityLevels[dayKey]?.append(newActivity)
                            } else {
                                vacation.activityLevels[dayKey] = [newActivity]
                            }
                        }

                        if let activities = vacation.activityLevels[dayKey] {
                            ForEach(activities.indices, id: \.self) { index in
                                HStack {
                                    Text("Entry \(index + 1): \(Int(activities[index]))")
                                    Spacer()
                                    GradientButton(label: "🗑️", colors: [Color.red, Color.orange]) {
                                        vacation.activityLevels[dayKey]?.remove(at: index)
                                    }
                                    .frame(width: 70)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                    // Notes
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Notes")
                            .font(.headline)

                        HStack {
                            TextField("New note", text: $newNote)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            GradientButton(label: "Add", colors: [Color.orange, Color.red]) {
                                if !newNote.isEmpty {
                                    if vacation.notes[dayKey] != nil {
                                        vacation.notes[dayKey]?.append(newNote)
                                    } else {
                                        vacation.notes[dayKey] = [newNote]
                                    }
                                    newNote = ""
                                }
                            }
                            .frame(width: 70)
                        }

                        if let notes = vacation.notes[dayKey] {
                            ForEach(notes.indices, id: \.self) { index in
                                HStack {
                                    Text(notes[index])
                                    Spacer()
                                    GradientButton(label: "🗑️", colors: [Color.red, Color.orange]) {
                                        vacation.notes[dayKey]?.remove(at: index)
                                    }
                                    .frame(width: 70)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            // Ensure energy, activity, notes exist for all days
            for day in vacation.days {
                if vacation.energyLevels[day] == nil { vacation.energyLevels[day] = [] }
                if vacation.activityLevels[day] == nil { vacation.activityLevels[day] = [] }
                if vacation.notes[day] == nil { vacation.notes[day] = [] }
            }
        }
    }
}

// Gradient Button Component
struct GradientButton: View {
    var label: String
    var colors: [Color]
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(
                    LinearGradient(gradient: Gradient(colors: colors),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
