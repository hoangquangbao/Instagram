//
//  UserRowShimmer.swift
//  Instagram
//
//  Created by lhduc on 04/11/2022.
//

import SwiftUI

struct UserRowShimmer: View {
    var body: some View {
        HStack {
            Circle().frame(width: 40, height: 40).shimmeringStyle(shape: .circle)
            VStack(alignment: .leading) {
                Rectangle().frame(width: 100, height: 10).shimmeringStyle()
                Rectangle().frame(width: 50, height: 10).shimmeringStyle()
            }
        }
    }
}

extension UserRowShimmer {
    func circleAvatar(radius: CGFloat) -> some View {
        Circle().frame(width: radius, height: radius).shimmeringStyle(shape: .circle)
    }
}

struct UserRowShimmer_Previews: PreviewProvider {
    static var previews: some View {
        UserRowShimmer()
    }
}
