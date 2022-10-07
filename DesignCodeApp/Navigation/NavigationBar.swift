//
//  NavigationBar.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/12/22.
//

import SwiftUI

struct NavigationBar: View {
    var title: String = ""
    @Binding var hasScrolled: Bool
    @State var showSearch = false
    @State var showAccount = false
    @AppStorage("showModal") var showSignUpModal = false
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            Text(title)
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
                .dynamicTypeSize(.large)
            
            HStack(spacing: 16) {
                Button{
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .foregroundColor(.secondary)
                        .strokeStyle(cornerRadius: 14)
                        .dynamicTypeSize(.large)
                }
                .sheet(isPresented: $showSearch) {
                    SearchView()
                }
                
                Button{
                    if isLogged{
                        showAccount = true
                    }else{
                        withAnimation(.easeInOut) {
                            showSignUpModal = true
                        }
                    }
                } label: {
                    AvatarView()
                }
                .accessibilityElement()
                .accessibilityLabel("Account")
                .accessibilityAddTraits(.isButton)
                .sheet(isPresented: $showAccount) {
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(false))
    }
}
