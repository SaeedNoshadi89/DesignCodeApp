//
//  SectionRow.swift
//  DesignCodeApp
//
//  Created by $@€€© on 10/5/22.
//

import SwiftUI

struct SectionRow: View {
    var section: CourseSection = courseSections[0]
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            Image(section.logo)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
                .padding(12)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
                .overlay(CircularView(value: section.progress))
            VStack(alignment: .leading, spacing: 8){
                Text(section.subtitle)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                    .dynamicTypeSize(sizeCategory > .extraExtraExtraLarge ? .xxxLarge : .xLarge)
                
                Text(section.title)
                    .fontWeight(.semibold)
                    .dynamicTypeSize(sizeCategory > .extraLarge ? .xLarge : .large)
                
                Text(section.text)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                    .lineLimit(sizeCategory > .large ? 2 : 1)
                
                ProgressView(value: section.progress)
                    .accentColor(.white)
                    .frame(maxWidth: 132)
            }
        }
        .padding(20)
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SectionRow()
    }
}
