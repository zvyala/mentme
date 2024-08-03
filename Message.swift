//
//  Message.swift
//  ment.me
//
//  Created by Zaynah Alam on 22/04/2024.
//
import Foundation
import FirebaseFirestore

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
    var sender: String
    var timestamp: Date

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case sender
        case timestamp
    }

    init(id: String? = nil, text: String, sender: String, timestamp: Date) {
        self.id = id
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.text = try container.decode(String.self, forKey: .text)
        self.sender = try container.decode(String.self, forKey: .sender)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(sender, forKey: .sender)
        try container.encode(timestamp, forKey: .timestamp)
    }
}
