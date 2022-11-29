//
//  Resource.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

class Resource {
    private static let logTag = "Resource"

    static func getInput(argument: String) -> String? {
        guard let filePath = ArgumentParser.getValue(argument: argument) else {
            Logger.e(self.logTag, "There is no argument \(argument)")
            return nil
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            Logger.v(self.logTag, "Loading \(filePath)")
            return try String(contentsOf: url)
        } catch {
            Logger.e(self.logTag, "Error loading resource from \(url.absoluteString)")
        }
        return nil
    }

    static func getInput(index: Int) -> String? {
        guard let filePath = ArgumentParser.getValue(index: index) else {
            Logger.e(self.logTag, "There is no argument at position \(index)")
            return nil
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            Logger.v(self.logTag, "Loading \(filePath)")
            return try String(contentsOf: url)
        } catch {
            Logger.e(self.logTag, "Error loading resource from \(url.absoluteString)")
        }
        return nil
    }
}
