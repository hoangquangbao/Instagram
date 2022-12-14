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
            VStack(alignment: .leading, spacing: 5) {
                Rectangle().frame(height: 10).shimmeringStyle()
                Rectangle().frame(height: 10).shimmeringStyle()
                Rectangle().frame(width: 100, height: 10).shimmeringStyle()
            }
            
            Rectangle().frame(width: 50, height: 50).shimmeringStyle()
        }
    }
}

struct NotificationInfoShimmer_Previews: PreviewProvider {
    static var previews: some View {
        NotificationInfoShimmer()
    }
}
