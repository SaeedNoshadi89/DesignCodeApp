//
//  FeaturedItem.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/12/22.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course = courses[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Image(course.logo)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(10)
                .padding(9)
                .background(.ultraThinMaterial, in:
                                RoundedRectangle(cornerRadius: 16.0, style:
                                        .continuous)
                )
                .strokeStyle(cornerRadius: 16)
            
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Text(course.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            Text(course.text)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
            
            
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20.0)
        .frame(height: 350.0)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
        //        .mask(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
        .strokeStyle()
        //        .overlay(RoundedRectangle(cornerRadius: 30.0, style: .continuous).stroke(.black, style: .init(lineWidth: 5.0, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [50.0, 10.0], dashPhase: 30.0)))
        .padding(.horizontal, 20.0)
        
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem()
    }
}
