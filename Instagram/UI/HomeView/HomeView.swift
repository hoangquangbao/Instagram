//
//  HomeView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                _storyBar
                
                Divider()
                
                _usersPost
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image.icnLogo
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    IconButton(imageIcon: Image.icnAddSquare) {
                        
                    }
                    
                    IconButton(imageIcon: Image.icnShare) {
                        
                    }
                }
            }
        }
        .navigationBarHidden(true)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

private extension HomeView {
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
    
    var _usersPost: some View {
        ForEach(MockData.posts) { post in
            PostRow(post: post)
        }
    }
    
    func _storyItem(of user: User) -> some View {
        VStack {
            CircleAvatar(image: Image(user.avatarUrl), radius: 55)
                .addGradientBorder(gradient: AppStyle.storyLinearGradient)
            
            Text(user.fullname)
                .font(.caption)
        }
        .padding(.top, 8)
    }
}


