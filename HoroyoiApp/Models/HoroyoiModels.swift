import Foundation

/// A single Suntory Horoyoi beverage flavor featured in the interactive eBook.
struct FlavorItem: Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let jpName: String
    let tagline: String
    let description: String
    let abv: Double
    let sweetness: Int
    let acidity: Int
    let imageName: String
    let accentColorHex: String
    let isSeasonal: Bool
    let pairings: [String]

    init(
        id: UUID = UUID(),
        name: String,
        jpName: String,
        tagline: String,
        description: String,
        abv: Double = 3.0,
        sweetness: Int,
        acidity: Int,
        imageName: String,
        accentColorHex: String,
        isSeasonal: Bool,
        pairings: [String]
    ) {
        self.id = id
        self.name = name
        self.jpName = jpName
        self.tagline = tagline
        self.description = description
        self.abv = abv
        self.sweetness = min(max(sweetness, 1), 5)
        self.acidity = min(max(acidity, 1), 5)
        self.imageName = imageName
        self.accentColorHex = accentColorHex
        self.isSeasonal = isSeasonal
        self.pairings = pairings
    }
}

/// An editorial lifestyle scene photo representing a relaxed Horoyoi moment.
struct ScenePhoto: Identifiable, Hashable, Sendable {
    let id: UUID
    let title: String
    let moodTag: String
    let imageName: String
    let storyQuote: String

    init(
        id: UUID = UUID(),
        title: String,
        moodTag: String,
        imageName: String,
        storyQuote: String
    ) {
        self.id = id
        self.title = title
        self.moodTag = moodTag
        self.imageName = imageName
        self.storyQuote = storyQuote
    }
}

/// A curated snack or dish recommended to pair with low-alcohol chuhai.
struct FoodPairing: Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let category: String
    let note: String
    let symbolName: String

    init(
        id: UUID = UUID(),
        name: String,
        category: String,
        note: String,
        symbolName: String
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.note = note
        self.symbolName = symbolName
    }
}
