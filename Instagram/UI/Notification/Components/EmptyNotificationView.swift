//
//  EmptyNotificationView.swift
//  Instagram
//
//  Created by lhduc on 13/12/2022.
//

import SwiftUI

struct EmptyNotificationView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Don't have any notification yet")
                .font(.system(.body))
                .foregroundColor(Color.semiText)
            Spacer()
        }
    }
}

struct EmptyNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyNotificationView()
    }
}
