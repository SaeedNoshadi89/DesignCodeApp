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
    @AppStorage("showModal") var showModal = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch selectedTab {
                case .home:
                    HomeView()
                    
                case .explore:
                    ExploreView()
                    
                case .notifications:
                   NotificationsView()
                    
                case .library:
                    LibraryView()
                    
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
            
            if showModal {
                ModalView()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
                    .accessibilityAddTraits(.isModal)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 88)
        }
        .dynamicTypeSize(.large ... .xxLarge)
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
