//
//  HomeView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    
    @State var _isNavigateAddPostView: Bool = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    _topBar
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        _storyBar
                        
                        Divider()
                        
                        _usersPost
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

private extension HomeView {
    var _topBar: some View {
        HStack(spacing: 15) {
            Image.icnLogo.renderingMode(.template).foregroundColor(Color.appPrimary)
            Spacer()
            _addStoryButton

            IconButton(imageIcon: Image.icnShare) {
                print("asdasd")
            }
            
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _storyBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15.0) {
                ForEach(vm.users) { user in
                    _storyItem(of: user)
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
    }
    
    func _storyItem(of user: User) -> some View {
        VStack {
            CircleAvatar(image: Image(user.avatarUrl), radius: 55)
                .addGradientBorder(gradient: AppStyle.storyLinearGradient)
            
            Text(user.fullName)
                .font(.caption)
        }
        .padding(.top, 8)
    }
    
    var _usersPost: some View {
        ForEach(MockData.posts) { post in
            PostRow(post: post)
        }
    }
    
    var _addStoryButton: some View {
        IconButton(imageIcon: Image.icnAddSquare) {
            _isNavigateAddPostView = true
        }
        .fullScreenCover(isPresented: $_isNavigateAddPostView) {
            NewPostView(user: vm.users[0])
        }
    }
}


