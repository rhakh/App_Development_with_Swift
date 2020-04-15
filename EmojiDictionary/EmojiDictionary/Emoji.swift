//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Роман Гах on 29.01.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Foundation

struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    static var ArchiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let _archiveURL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
        return _archiveURL;
    }
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }

    static func saveToFile(_ emojis: [Emoji]) {
        let encoder = PropertyListEncoder()
        let encodedEmojis = try? encoder.encode(emojis)

        try? encodedEmojis?.write(to: Emoji.ArchiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [Emoji]? {
        let decoder = PropertyListDecoder()
        if let retrivedEmojis = try? Data(contentsOf: Emoji.ArchiveURL) {
            if let decodedEmojis = try? decoder.decode(Array<Emoji>.self, from: retrivedEmojis) {
                return decodedEmojis
            }
        }
        return nil
    }

    static func loadSampleEmojis() -> [Emoji] {
        let emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",
        description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",
        description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",
        description: "A smiley face with hearts for eyes.",
        usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer",
        description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle", description:
        "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description:
        "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",
        description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
        description: "Three colored books stacked on each other.",
        usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",
        description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore",
        description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",
        description: "A black-and-white checkered flag.", usage: "completion"),
        Emoji(symbol: "🐙", name: "Octopus", description: "A cute octopus", usage: "Changing color"),
        Emoji(symbol: "🌚", name: "Moon", description: "Full moon", usage: "Night"),
        Emoji(symbol: "🌝", name: "Sun", description: "Shining sub", usage: "Day"),
        Emoji(symbol: "🌈", name: "Rainbow", description: "Colorful rainbow", usage: "Fun"),
        Emoji(symbol: "❄️", name: "Snowflake", description: "Unique snowflake", usage: "Something unique"),
        Emoji(symbol: "🏎", name: "F1 car", description: "Fast car for raicing", usage: "Something very fast"),
        Emoji(symbol: "📱", name: "Smartphone", description: "Mobile phone", usage: "mobile"),
        Emoji(symbol: "🇺🇦", name: "Ukraine flag", description: "Flag of the Ukraine", usage: "Nacional symbol"),
        Emoji(symbol: "🤡", name: "Clown face", description: "Funny smilling clown face", usage: "Something fun"),
        Emoji(symbol: "🦁", name: "Lion", description: "Lion, king of the animals", usage: "For kings")]

        return emojis
    }
}

