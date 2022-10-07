//
//  SearchView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/26/22.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var model: Model
    @Namespace var namespace
    @State private var selectedIndex = 0
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        SearchNavigationView
    }
    
    var SearchNavigationView: some View {
        NavigationView {
            ScrollView{
                VStack {
                    content
                }
                .padding(20)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokeStyle(cornerRadius: 30)
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .blur(radius: 20)
                        .offset(y: -200)
                )
                .background(
                    Image("Blob 1")
                        .offset(x: -100, y: -200)
                )
            }
            .searchable(
                text: $text,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("SwiftUi, React, UI Design")
            ) {
                ForEach(suggestions){ suggestion in
                    Button{
                        text = suggestion.text
                    } label: {
                        Text(suggestion.text)
                            .searchCompletion(suggestion.text)
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button{
                dismiss()
            } label: {
                Text("Done").bold()
            })
            .sheet(isPresented: $model.showDetail) {
                CourseView(namespace: namespace, course: courses[selectedIndex])
            }
        }
    }
    
    var content: some View {
        ForEach(Array(courses.enumerated()), id: \.offset) { index, item in
            if item.title.contains(text) || text == "" {
                if index != 0 { Divider() }
                Button {
                    model.showDetail = true
                    selectedIndex = index
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .background(Color("Background"))
                            .mask(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title).bold()
                                .foregroundColor(.primary)
                            Text(item.text)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
            }
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(Model())
    }
}
