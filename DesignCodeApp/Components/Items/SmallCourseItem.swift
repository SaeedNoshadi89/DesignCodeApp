//
//  SmallCourseItem.swift
//  DesignCodeApp
//
//  Created by $@€€© on 10/6/22.
//

import SwiftUI

struct SmallCourseItem: View {
    var course: Course = courses[0]
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: sizeCategory > .extraExtraLarge ? 1 : 2){
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.black.opacity(0.1))
                .overlay {
                    Image(course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 105)
                }
            Text(course.subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(sizeCategory > .large ? 1 : 2)
            Text(course.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(sizeCategory > .small ? 1 : 2)
        }
        .padding()
        .frame(width: 160, height: 200)
        .background(.ultraThinMaterial, in:
                        RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .dynamicTypeSize(.large ... .xxxLarge)
    }
}

struct SmallCourseItem_Previews: PreviewProvider {
    static var previews: some View {
        SmallCourseItem()
    }
}
