//
//  AccountView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 8/1/22.
//

import SwiftUI

struct AccountView: View {
    @State var isDeleted = false
    
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
                
                
                //MARK: Section One
                Section {
                    NavigationLink {ContentView()} label: {
                        Label("Settings", systemImage: "gear")
                    }
                    NavigationLink { Text("Billing") } label: {
                        Label("Billing", systemImage: "creditcard")
                    }
                    NavigationLink { ContentView() } label: {
                        Label("Help", systemImage: "questionmark")
                    }
                }
                .listRowSeparatorTint(.blue)
                .listRowSeparator(.hidden)
                
                //MARK: Section Two
                Section{
                    Link(destination: URL(string: "https://apple.com")!){
                        HStack {
                            Label("Website", systemImage: "house")
                            Spacer()
                            Image(systemName: "link")
                                .accentColor(.blue)
                        }
                    }
                    if !isDeleted {
                        Link(destination: URL(string: "https://youtube.com")!){
                            HStack{
                                Label("Youtube", systemImage: "tv")
                                Spacer()
                                Image(systemName: "link")
                                    .accentColor(.blue)
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true){
                            Button(action: { isDeleted = true }) {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                            
                            Button {} label: {
                                Label("Pin", systemImage: "pin")
                            }
                        }
                    }
                }
                .accentColor(.primary)
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
