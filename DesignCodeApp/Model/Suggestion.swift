//
//  Suggestion.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/27/22.
//

import SwiftUI

struct Suggestion: Identifiable{
    let id = UUID()
    var text: String
}

var suggestions = [
    Suggestion(text: "Swift"),
    Suggestion(text: "React"),
    Suggestion(text: "Design")
]
