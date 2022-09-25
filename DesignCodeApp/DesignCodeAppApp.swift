//
//  DesignCodeAppApp.swift
//  DesignCodeApp
//
//  Created by $@€€© on 7/27/22.
//

import SwiftUI

@main
struct DesignCodeAppApp: App {
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
