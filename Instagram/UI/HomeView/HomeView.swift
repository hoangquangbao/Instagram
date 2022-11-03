//
//  HomeView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    @EnvironmentObject var sessionService: SessionService
    
    var body: some View {
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionService())
    }
}

private extension HomeView {
    var _topBar: some View {
        HStack(spacing: 15) {
            Image.icnLogo.renderingMode(.template).foregroundColor(Color.appPrimary)
            Spacer()
            _createNewPostButton
            
            IconButton(imageIcon: Image.icnShare) {
                print("asdasd")
            }
            
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _storyBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15.0) {
                _createNewStoryButton
                
                ForEach(vm.users) { user in
                    _storyItem(of: user)
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
    }
    
    var _createNewStoryButton: some View {
        VStack {
            Button {
                vm.isShowNewStoryView.toggle()
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    if let userInfo = sessionService.userInfo {
                        CircleAvatar(imageUrl: userInfo.avatarUrl, radius: 55)
                            .addBorder(Color.clear)
                    } else {
                        Color._3C3C43.frame(width: 55, height: 55).clipShape(Circle())
                    }
                    
                    ZStack {
                        Circle().fill(Color.ffffff).frame(width: 25, height: 25)
                        Image(systemName: "plus.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.blue)
                            .background(Color.clear)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .fullScreenCover(isPresented: $vm.isShowNewStoryView) {
                if let userInfo = sessionService.userInfo {
                    NewStoryView(user: userInfo)
                }
            }
            
            Text("Your story")
                .font(.caption)
            
        }
        .padding(.top, 8)
    }
    
    func _storyItem(of user: User) -> some View {
        VStack {
            CircleAvatar(imageUrl: user.avatarUrl, radius: 55)
                .addGradientBorder(gradient: AppStyle.storyLinearGradient)
            
            Text(user.fullName)
                .font(.caption)
        }
        .padding(.top, 8)
    }
    
    var _usersPost: some View {
        ForEach(vm.posts) { post in
            PostRow(post: post)
        }
    }
    
    var _createNewPostButton: some View {
        IconButton(imageIcon: Image.icnAddSquare) {
            vm.isShowNewPostView.toggle()
        }
        .fullScreenCover(isPresented: $vm.isShowNewPostView) {
            if let userInfo = sessionService.userInfo {
                NewPostView(user: userInfo)
            }
        }
    }
}


