//
//  UserProfileView.swift
//  Instagram
//
//  Created by Tran Thuan on 27/09/2022.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0){
//            Divider()
//            Button(action:{
//
//            }){
//                Text("View Professional Resources")
//                    .font(Font.system(size: 11, weight: .medium))
//                    .frame(width:.infinity)
//                    .padding(.vertical, 12)
//                    .padding(.horizontal, 30)
//            }
//            Divider()
            VStack(alignment: .leading){
                UserInfoView()
                Text("")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.top, 5)
                    .padding(.bottom, 1)
                Text("👨‍💻 I love Coding 💙\n🧬 Software Engineer\n📪 DM me for any query regarding iOS")
                    .font(Font.system(size: 13, weight: .regular))


                    .foregroundColor(Color(red:9/255, green:55/255, blue:107/255))
                ProfileActionsView()
                    .padding(.top, 10)
            }//: VSTACK
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .previewLayout(.sizeThatFits)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
    }
}
