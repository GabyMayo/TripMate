import SwiftUI

struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var name: String
}

struct NoteItem: Identifiable, Codable {
    var id = UUID()
    var text: String
}

struct DailyData: Identifiable {
    var id = UUID()
    var date: Date
    var energy: [Double]
    var activity: [Double]
    var notes: [NoteItem]
}
