//
//  PreferenceKeys.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/14/22.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ViewOffsetKey: PreferenceKey{
    typealias Value = CGFloat
    static var defaultValue: CGFloat = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
