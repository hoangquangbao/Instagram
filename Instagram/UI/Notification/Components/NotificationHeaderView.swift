//
//  NotificationHeaderView.swift
//  Instagram
//
//  Created by lhduc on 13/12/2022.
//

import SwiftUI

struct NotificationHeaderView: View {
    var body: some View {
        HStack {
            Text("Notifications")
                .font(.system(.title2))
                .bold()
                .padding(AppStyle.defaultSpacing)
            
            Spacer()
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct NotificationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationHeaderView()
    }
}
