//
//  HomeView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/12/22.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView{
                scrollDetection
                featuredTabView
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
                withAnimation(.easeInOut){
                    if value < 0 {
                        hasScrolled = true
                    }else{
                        hasScrolled = false
                    }
                }
            })
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay {
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            }
        }
        
    }
    
    var scrollDetection: some View{
        GeometryReader { proxy in
            //                Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        
    }
    
    var featuredTabView: some View{
        TabView {
            ForEach(courses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees( minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX / 40))
                        .overlay(Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 230)
                            .offset(x: 32, y: -90)
                            .offset(x: minX / 2)
                        )

                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(Image("Blob 1")
            .offset(x: 250, y: -100))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
