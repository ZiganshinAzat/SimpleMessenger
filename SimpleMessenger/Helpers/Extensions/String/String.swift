//
//  String.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 30.07.2024.
//

import Foundation

extension String {
    static func localize(_ text: String.LocalizationValue) -> String {
        String(localized: text)
    }
}

// MARK: UserInfo Keys
extension String {
    static let state = "state"
}

// MARK: Firebase Keys
extension String {
    static let users = "users"
    static let conversations = "conversations"
    static let messages = "messages"
}

extension String {
    func truncate(to limit: Int, ellipsis: Bool = true) -> String {
        if count > limit {
            let truncated = String(prefix(limit)).trimmingCharacters(in: .whitespacesAndNewlines)
            return ellipsis ? truncated + "\u{2026}" : truncated
        } else {
            return self
        }
    }
}
