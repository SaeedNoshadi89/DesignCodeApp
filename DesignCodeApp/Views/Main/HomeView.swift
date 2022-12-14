//
//  HomeView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/12/22.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
//    @State var show = false
    @State var showStatusBar = true
    @State var selectedId = UUID()
    @EnvironmentObject var model: Model
    @AppStorage("isLiteMode") var isLiteMode = true
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView{
                scrollDetection
                featuredTabView
                
                Text("Course".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .dynamicTypeSize(.large)
                
//                if !show{
//                    cards
//                }else{
//                    ForEach(courses) { course in
//                        Rectangle()
//                            .fill(.white)
//                            .frame(height: 350)
//                            .cornerRadius(30)
//                            .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
//                            .opacity(0.3)
//                        .padding(.horizontal, 30)
//                    }
//                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !model.showDetail{
                        cards
                    }else{
                        ForEach(courses) { course in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 350)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                            .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay (
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            )
            
            if model.showDetail{
                detail
            }
        }
        .statusBarHidden(!showStatusBar)
        .onChange(of: model.showDetail) { newValue in
            withAnimation(.closeCard){
                if newValue {
                    showStatusBar = false
                }else{
                    showStatusBar = true
                }
            }
        }
    }
    
    var scrollDetection: some View{
        GeometryReader { proxy in
            //                Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut){
                if value < 0 {
                    hasScrolled = true
                }else{
                    hasScrolled = false
                }
            }
        })
        
    }
    
    var featuredTabView: some View{
        TabView {
            ForEach(featuredCourses) { course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(course: course)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees( minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3), radius: 5, x: 0, y: 3)
                        .blur(radius: abs(minX / 40))
                        .overlay(Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 230)
                            .offset(x: 32, y: -90)
                            .offset(x: minX / 2)
                        )
                        .frame(maxWidth: 600)
                        .frame(maxWidth: .infinity)
                        .accessibilityElement(children: .combine)
                    
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(Image("Blob 1")
            .offset(x: 250, y: -100)
            .accessibilityHidden(true)
        )
    }
    
    var cards: some View{
        ForEach(courses) { course in
            CourseItem(namespace: namespace, course: course)
                .onTapGesture {
                    withAnimation(.openCard){
//                        show.toggle()
                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedId = course.id
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }
    }
    
    var detail: some View{
        CourseView(namespace: namespace, course: courses.first { firstCourse in
            selectedId == firstCourse.id
        } ?? courses[0])
        .zIndex(1)
        .transition(.asymmetric(
            insertion: .opacity.animation(.easeInOut(duration: 0.1)),
            removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}
