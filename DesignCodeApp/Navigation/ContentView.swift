//
//  ContentView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage ("selectedTab") var selectedTab: Tab = .home
    @AppStorage ("selectedColor") var selectedColor: String = ""
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch selectedTab {
                case .home:
                    HomeView()
                    
                case .explore:
                    AccountView()
                    
                case .notifications:
                    AccountView()
                    
                case .library:
                    AccountView()
                    
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
        }
        .environmentObject(Model())
    }
}
