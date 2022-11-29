//
//  ArgumentParser.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

enum ArgumentParser {
    static func getValue(argument name: String) -> String? {
        for argument in CommandLine.arguments {
            let parts = argument.split(separator: "=")
            guard parts.count == 2 else { continue }
            let paramName = parts[0]
            let paramValue = parts[1]
            if paramName == name {
                let value = paramValue.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                return value
            }
        }
        return nil
    }

    static func getValue(index: Int) -> String? {
        CommandLine.arguments[safeIndex: 1 + index]
    }
}
