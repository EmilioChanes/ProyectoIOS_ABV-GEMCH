import SwiftData

@Model
final class SavedMovie {
    var id: Int
    var title: String
    var year: String

    init(
        id: Int,
        title: String,
        year: String
    ) {
        self.id = id
        self.title = title
        self.year = year
    }
}