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
    @AppStorage("showModal") var showSignUpModal = false
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
            
            if showSignUpModal {
                ZStack {
                    Color.clear.background(.regularMaterial)
                        .ignoresSafeArea()
                    
                    SignUpView()
                    
                    button
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                .zIndex(1)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
    
    var button: some View{
        Button {
            withAnimation {
                showSignUpModal = false
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
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
