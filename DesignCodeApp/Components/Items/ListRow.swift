//
//  ListRow.swift
//  DesignCodeApp
//
//  Created by $@€€© on 10/6/22.
//

import SwiftUI

struct ListRow: View {
    @Environment(\.sizeCategory) var sizeCategory
    var topic: Topic = topics[0]
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: topic.icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
            Text(topic.title)
                .fontWeight(.semibold)
                .lineLimit(sizeCategory > .extraExtraExtraLarge ? 1 : 2)
            Spacer()
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow()
    }
}
