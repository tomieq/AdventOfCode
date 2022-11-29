//
//  Logger.swift
//
//
//  Created by Tomasz on 29/11/2022.
//

import Foundation

enum Logger {
    public static var executor: ((_ label: String?, _ log: String) -> Void) = Self.defaultExecutor(_:_:)

    public static func v(_ label: String?, _ log: String) {
        Self.executor(label, log)
    }

    public static func e(_ label: String?, _ log: String) {
        Self.executor(label.readable + "❗", log)
    }

    private static func defaultExecutor(_ label: String?, _ log: String) {
        let log = log.replacingOccurrences(of: "\\/", with: "/")
        let localMessage = "\(Self.logDate()) [\(label.readable)] \(log)"
        print(localMessage)
    }

    private static func logDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }
}
