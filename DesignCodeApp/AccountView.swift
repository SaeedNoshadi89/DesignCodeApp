//
//  AccountView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 8/1/22.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            List{
                VStack(spacing: 8){
                    Image(systemName: "person.crop.circle.badge.checkmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(size: 32))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue, .blue.opacity(0.3))
                        .padding()
                        .background(Circle().fill(.ultraThinMaterial))
                        .background(
                            Image(systemName: "hexagon")
                            .symbolVariant(.fill)
                            .foregroundColor(.blue)
                            .font(.system(size: 200))
                            .offset(x: -50, y: -100)
                    )
                    Text("Saeed Noshadi")
                        .font(.system(.title, design: .rounded).weight(.semibold))
//                    Label("Iran", systemImage: "location")
//                        .foregroundColor(.secondary)
                    HStack{
                        Image(systemName: "location")
                            .imageScale(.large)
                        Text("Iran")
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Section {
                    Label("Settings", systemImage: "gear")
                    Label("Billing", systemImage: "creditcard")
                    Label("Help", systemImage: "questionmark")
                }
                .listRowSeparatorTint(.blue)
                .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
