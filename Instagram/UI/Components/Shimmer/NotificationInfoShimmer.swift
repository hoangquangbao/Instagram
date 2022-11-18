//
//  NotificationInfoShimmer.swift
//  Instagram
//
//  Created by lhduc on 18/11/2022.
//

import SwiftUI

struct NotificationInfoShimmer: View {
    var body: some View {
        HStack(alignment: .center) {
            UserRowShimmer().circleAvatar(radius: 50)
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { proxy in
                    Rectangle().frame(width: proxy.size.width, height: 10).shimmering()
                }
                
                GeometryReader { proxy in
                    Rectangle().frame(width: proxy.size.width, height: 10).shimmering()
                }
                
                Rectangle().frame(width: 50, height: 8).shimmering()
            }
            
            Rectangle().frame(width: 50, height: 50).shimmering()
        }
    }
}

struct NotificationInfoShimmer_Previews: PreviewProvider {
    static var previews: some View {
        NotificationInfoShimmer()
    }
}
