//
//  Codable+extension.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

extension Encodable {
    var json: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else {
            return "{}"
        }
        return String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/") ?? "{}"
    }
}

extension Decodable {
    init(json: String) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: json.data(using: .utf8)!)
    }

    init(jsonData: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: jsonData)
    }
}
