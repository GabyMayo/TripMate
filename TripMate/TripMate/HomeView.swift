import SwiftUI

struct HomeView: View {
    @State private var vacations: [Vacation] = []
    @State private var newVacationName: String = ""
    @State private var newVacationDays: String = "" // input number of days

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to TripMate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Add new vacation
                HStack(spacing: 15) {
                    TextField("New Vacation Name", text: $newVacationName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                        .padding(.vertical, 5)

                    TextField("# of Days", text: $newVacationDays)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                        .padding(.vertical, 5)

                    Button(action: addVacation) {
                        Text("Add")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(
                                LinearGradient(
                                    colors: [Color(red: 0.498, green: 0.533, blue: 0.851),
                                             Color(red: 0.698, green: 0.6, blue: 0.773)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(20)
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)

                List {
                    ForEach(vacations.indices, id: \.self) { index in
                        NavigationLink(destination: VacationDetailView(vacation: $vacations[index])) {
                            Text(vacations[index].name)
                                .font(.headline)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                )
                        }
                    }
                    .onDelete { indices in
                        vacations.remove(atOffsets: indices)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding(.top)
            .frame(minWidth: 600, minHeight: 400)
            .background(Color(red: 0.7, green: 0.7, blue: 0.9).opacity(0.1))
        }
    }

    private func addVacation() {
        if !newVacationName.isEmpty, let days = Int(newVacationDays), days > 0 {
            let dayNames = (1...days).map { "Day \($0)" }
            vacations.append(Vacation(name: newVacationName, days: dayNames))
            newVacationName = ""
            newVacationDays = ""
        }
    }
}

// Vacation model
struct Vacation {
    var name: String
    var days: [String] = []
    var energyLevels: [String: [Double]] = [:]    // day: [values 1-10]
    var activityLevels: [String: [Double]] = [:]  // day: [values 1-10]
    var notes: [String: [String]] = [:]           // day: notes
    var todos: [String: [String]] = [:]           // day: [to-dos]
}
