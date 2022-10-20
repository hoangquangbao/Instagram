//
//  TabbarBottomView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct TabbarBottomView: View {
    
    @State private var selection = 0
    
    var body: some View {
        VStack(spacing: 0.0) {
            TabView(selection: $selection) {
                HomeView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
                        selection == 0 ? Image.icnHomeBold : Image.icnHome
                    }
                    .tag(0)
                SearchView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
                        selection == 1 ? Image.icnSearchBold : Image.icnSearch
                    }
                    .tag(1)
                ProfileView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
                        Image.icnAddSquare
                    }
                    .tag(2)
                ProfileView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
                        selection == 3 ? Image.icnHeartBold : Image.icnHeart
                    }
                    .tag(3)
                ProfileView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {    
                        Image.icnPfTabbar
                            .resizable()
                            .frame(width: 21, height: 21)
                            .cornerRadius(50)
                    }
                    .tag(4)
            }
        }
    }
}

struct TabbarBottomView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarBottomView()
    }
}

