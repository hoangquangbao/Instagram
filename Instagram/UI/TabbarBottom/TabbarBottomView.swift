//
//  TabbarBottomView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

@available(iOS 16.0, *)
struct TabbarBottomView: View {
    @EnvironmentObject var vm: LoginViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @EnvironmentObject var storyData: StoryViewModel
    
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                TabView(selection: $selection) {
                    HomeView()
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .tabItem {
                            _TabBarIcon(selection == 0 ? Image.icnHomeBold : Image.icnHome)
                        }
                        .tag(0)
                    SearchView()
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .tabItem {
                            _TabBarIcon(selection == 1 ? Image.icnSearchBold : Image.icnSearch)
                        }
                        .tag(1)
                    NewPostView(user: MockData.users[0])
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .tabItem {
                            _TabBarIcon(Image.icnAddSquare)
                        }
                        .tag(2)
                    ProfileView()
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .tabItem {
                            _TabBarIcon(selection == 3 ? Image.icnHeartBold : Image.icnHeart)
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
                .accentColor(Color.appPrimary)
            }
            .navigationBarBackButtonHidden(true)
            .background {
                Color.appPrimary
            }
            
            if(storyData.isStoryDisplay) {
                StoryView()
            }
        }
    }
}

struct _TabBarIcon: View {
    private let _icon: Image
    
    init(_ icon: Image) {
        _icon = icon
    }
    
    var body: some View {
        _icon.renderingMode(.template).foregroundColor(Color._000000)
    }
}

@available(iOS 16.0, *)
struct TabbarBottomView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarBottomView()
            .environmentObject(SessionViewModel())
    }
}

