//
//  HomeView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI
import Shimmer

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var userVm : UserViewModel
    @EnvironmentObject var postVm : PostViewModel
    @EnvironmentObject var storyVm: StoryViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                _topBar
                
                ScrollView(.vertical, showsIndicators: false) {
                    _storyBar
                    
                    Divider()
                    
                    if(postVm.isFetching) {
                        PostRowShimmer()
                    }
                    else {
                        _usersPost
                    }
                }
            }
            .navigationBarHidden(true)
            .confirmationDialog(
                "choose option",
                isPresented: $vm.isShowOptionForNavigateStoryView,
                actions: {
                    Button("Create story")  { vm.isShowNewStoryView.toggle() }
                    Button("Show my story") {
                        vm.isStoryDisplay.toggle()
                        storyVm.activeStories = storyVm.userStories(of: sessionViewModel.uid)
                        withAnimation(.default) {
                            storyVm.isStoryDisplay.toggle()
                        }
                    }
                },
                message: { Text("Please choose one option") }
            )
        }
    }
}

private extension HomeView {
    var _topBar: some View {
        HStack(spacing: 15) {
            Image.icnLogo.renderingMode(.template).foregroundColor(Color.appPrimary)
            
            Spacer()
            
            _createNewPostButton
            
            IconButton(imageIcon: Image.icnShare) { print("message") }
            
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _storyBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15.0) {
                CreateNewStoryButton(homeVm: vm)
                
                if(userVm.isFetching) {
                    StoryAvatarShimmer()
                } else {
                    ForEach(userVm.userHasStory) { user in
                        StoryAvatar(user: user)
                            .padding(.top, 8)
                    }
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
    }
    
    var _usersPost: some View {
        ForEach(postVm.posts) { post in
            PostRow(post: post)
                .padding(.top, 15)
        }
    }
    
    var _createNewPostButton: some View {
        IconButton(imageIcon: Image.icnAddSquare) {
            vm.isShowNewPostView.toggle()
        }
        .fullScreenCover(isPresented: $vm.isShowNewPostView) {
            if let userInfo = sessionViewModel.userInfo {
                NewPostView(user: userInfo)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionViewModel())
    }
}

