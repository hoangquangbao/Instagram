//
//  UserRowShimmer.swift
//  Instagram
//
//  Created by Nguyễn Lâm Hoàng Anh on 04/11/2022.
//

import SwiftUI

struct UserRowShimmer: View {
    var body: some View {
        HStack {
            Circle().frame(width: 40).shimmering()
            VStack(alignment: .leading) {
                Rectangle().frame(width: 100, height: 10).shimmering()
                Rectangle().frame(width: 50, height: 10).shimmering()
            }
        }
    }
}

extension UserRowShimmer {
    func circleAvatar(radius: CGFloat) -> some View {
        Circle().frame(width: radius).shimmering()
    }
}

struct UserRowShimmer_Previews: PreviewProvider {
    static var previews: some View {
        UserRowShimmer()
    }
}
