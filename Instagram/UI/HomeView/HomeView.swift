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
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                _topBar
                
                ScrollView(.vertical, showsIndicators: false) {
                    _storyBar
                    
                    Divider()
                    
                    if postVm.posts.isNotEmpty {
                        _usersPost
                    } else {
                        PostRowShimmer()
                    }
                    
                }
            }
        }
        .confirmationDialog(
            "choose option",
            isPresented: $vm.isShowOptionForNavigateStoryView,
            actions: {
                Button("Create story")  { vm.isShowNewStoryView.toggle() }
                Button("Show my story") {
                    vm.isStoryDisplay.toggle()
                    storyVm.activeStories = storyVm.userStories(forUid: sessionViewModel.uid)
                    withAnimation(.default) {
                        storyVm.isStoryDisplay.toggle()
                    }
                }
            },
            message: {
                Text("Please choose one option")
            }
        )
        .onAppear {
            userVm.refresh()
            postVm.refresh()
            storyVm.refresh()
        }
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
    
    var _createNewStoryButton: some View {
        VStack {
            Button {
//                vm.isShowNewStoryView.toggle()
                vm.isShowOptionForNavigateStoryView.toggle()
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    if let userInfo = sessionViewModel.userInfo {
                        if(userInfo.hasStory) {
                            CircleAvatar(imageUrl: userInfo.avatarUrl, radius: 55)
                                .addGradientBorder(gradient: AppStyle.storyLinearGradient)
                        } else {
                            CircleAvatar(imageUrl: userInfo.avatarUrl, radius: 55)
                                .addBorder(Color.clear)
                        }
                    } else {
                        UserRowShimmer().circleAvatar(radius: 55)
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
                if let userInfo = sessionViewModel.userInfo {
                    NewStoryView(user: userInfo)
                }
            }
            
            Text("Your story").font(.caption)
            
        }
        .padding(.top, 8)
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

struct StoryAvatar: View {
    let user: User
    @EnvironmentObject var storyVm: StoryViewModel
    @EnvironmentObject var userVm: UserViewModel
    
    var body: some View {
        if userVm.isFetching {
            StoryAvatarShimmer()
        } else {
            VStack {
                Button {
                    guard let uid = user.id else { return }
                    storyVm.activeStories = storyVm.userStories(forUid: uid)
                    withAnimation(.default) {
                        storyVm.isStoryDisplay.toggle()
                    }
                } label: {
                    CircleAvatar(imageUrl: user.avatarUrl, radius: 55)
                        .addGradientBorder(gradient: AppStyle.storyLinearGradient)
                }
                
                Text(user.fullName)
                    .font(.caption)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(width: 65)
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

