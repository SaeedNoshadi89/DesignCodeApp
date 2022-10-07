//
//  AccountView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 8/1/22.
//

import SwiftUI

struct AccountView: View {
    @State var isDeleted = false
    @State var isPinned = false
    @State var address: Address = Address(id: 1, country: "...")
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isLogged") var isLogged = false
    @ObservedObject var coinModel = CoinModel()
    @AppStorage("isLiteMode") var isLiteMode = true

    
    func fetchAddress() async{
        do{
            let url = URL(string: "https://random-data-api.com/api/v2/addresses")!
//            guard let notNilUrl = url else{
//                return
//            }
            let (data, _) = try await URLSession.shared.data(from: url)
            print(String(decoding: data, as: UTF8.self))
            address = try JSONDecoder().decode(Address.self, from: data)
        }catch{
            // Show error
            address = Address(id: -1, country: "Error fetching")
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                profile
                
                //MARK: Section One
                menu
                
                Section{
                    Toggle(isOn: $isLiteMode){
                        Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "hare")
                    }
                }
                .accentColor(.primary)
                //MARK: Section Two
                links
                
                coins
                
                Button{
                    isLogged = false
                    dismiss()
                } label: {
                    Text("Sign out")
                        .tint(.red)
                }
                
            }
            .task {
                await fetchAddress()
                await coinModel.fetchCoins()
            }
            .refreshable(action: {
                await fetchAddress()
                await coinModel.fetchCoins()
            })
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing:
                                    Button{
                dismiss()
                
            } label: {
                Text("Done").bold()
            })
            
        }
    }
    
    var profile: some View{
        VStack(spacing: 8){
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                   HexagonView()
                        .offset(x: -50, y: -100)
                )
                
            Text("Saeed Noshadi")
                .font(.system(.title, design: .rounded).weight(.semibold))
                .lineLimit(1)
            HStack{
                Image(systemName: "location")
                    .imageScale(.large)
                Text(address.country)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            BlobView()
                .offset(x: 200, y: 0)
                .scaleEffect(0.6)
        )
    }
    
    var menu: some View{
        Section {
            NavigationLink {HomeView()} label: {
                Label("Settings", systemImage: "gear")
            }
            NavigationLink { Text("Billing") } label: {
                Label("Billing", systemImage: "creditcard")
            }
            NavigationLink { HomeView() } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    var links: some View{
        Section{
            Link(destination: URL(string: "https://apple.com")!){
                HStack {
                    Label("Website", systemImage: "house")
                    Spacer()
                    Image(systemName: "link")
                        .accentColor(.blue)
                }
            }
            .swipeActions{
                pinButton
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
                    pinButton
                }
            }
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var coins: some View{
        Section {
            ForEach(coinModel.coins){ coin in
                HStack {
                    AsyncImage(url: URL(string: coin.logo)){image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coin_name)
                        Text(coin.acronym)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        } header: {
            Text("Coins")
        }

    }
    
    var pinButton: some View{
        Button {isPinned.toggle()} label: {
            if isPinned{
                Label("Unpin", systemImage: "pin.slash")

            }else{
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
