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
//                        selection == 0 ? Image.icnHome : Image.icnUnHome
                    }
                    .tag(0)
                HomeView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
                        Image.icnSearch
//                        selection == 1 ? Image.icnSearch : Image.icnUnSearch
                    }
                    .tag(1)
                HomeView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
                        Image.icnAdd
                    }
                    .tag(2)
                HomeView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {
//                        selection == 3 ? Image.icnHeart : Image.icnUnHeart
                    }
                    .tag(3)
                HomeView()
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tabItem {    // 2
//                        Image.icnPfTabbar
//                            .resizable()
//                            .frame(width: 21, height: 21)
//                            .cornerRadius(50)
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

