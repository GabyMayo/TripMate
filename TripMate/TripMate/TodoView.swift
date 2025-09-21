import SwiftUI

struct TodoView: View {
    @Binding var vacation: Vacation
    @State private var selectedDay = "Day 1"
    @State private var newTask: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Day Picker
            Picker("Select Day", selection: $selectedDay) {
                ForEach(vacation.energyLevels.keys.sorted(), id: \.self) { day in
                    Text(day).tag(day)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            // Add new task
            HStack {
                TextField("New Task", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    if !newTask.isEmpty {
                        vacation.tasks[selectedDay, default: []].append(newTask)
                        newTask = ""
                    }
                }
                .padding(.horizontal)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            // Task List
            List {
                ForEach(Array(vacation.tasks[selectedDay, default: []].enumerated()), id: \.offset) { index, task in
                    HStack {
                        Text(task)
                        Spacer()
                        Button {
                            vacation.tasks[selectedDay]?.remove(at: index)
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .navigationTitle("\(vacation.name) To-Do")
        .background(Color(red: 0.5, green: 0.78, blue: 0.8))
    }
}

// Extend Vacation model
extension Vacation {
    var tasks: [String: [String]] {
        get { self._tasks ?? [:] }
        set { self._tasks = newValue }
    }
    private var _tasks: [String: [String]]? {
        get { objc_getAssociatedObject(self, &tasksKey) as? [String: [String]] }
        set { objc_setAssociatedObject(self, &tasksKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

private var tasksKey: UInt8 = 0
