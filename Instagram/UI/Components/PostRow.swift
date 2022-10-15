//
//  PostRow.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    @State private var _currentStep = 0
    
    var body: some View {
        ZStack {
            Color.background
            VStack(alignment: .leading, spacing: 0.0) {
                _header
                
                _content
                
                Text("Liked by Meng To and others")
                    .font(.footnote)
                    .padding(.horizontal, 12)
                
                Text(post.caption)
                    .font(.footnote)
                    .padding(.horizontal, 12)
                
                HStack {
                    HStack(spacing: 7.0) {
                        if let user = post.user {
                            Image(user.avatarUrl)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .cornerRadius(50)
                        }
                        
                        Text("Add comment...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    
                    Spacer()
                }
            }
        }
    }
}

private extension PostRow {
    var _header: some View {
        HStack {
            HStack(spacing: 9.0) {
                if let user = post.user {
                    CircleAvatar(image: Image(user.avatarUrl), radius: 40)
                    VStack(alignment: .leading) {
                        Text(user.fullname)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("@\(user.username)")
                            .font(.caption)
                            .fontWeight(.light)
                    }
                }
            }
            
            Spacer()
            
            Image.icnMore
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 15)
        .padding(.bottom, 8)
    }
    
    var _content: some View {
        VStack {
            TabView(selection: $_currentStep) {
                ForEach(0..<post.imagesUrl.count, id: \.self) { index in
                    ZStack() {
                        HStack() {
                            Image(post.imagesUrl[index])
                                .resizable()
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                                .scaledToFill()
                        }
                        VStack(alignment: .leading) {
                            HStack() {
                                Spacer()
                                HStack() {
                                    Text("\(index + 1)/\(post.imagesUrl.count)")
                                        .font(.system(size: 12))
                                }
                                .padding(7)
                                .background(Color._121212.opacity(0.7))
                                .foregroundColor(Color.f9F9F9)
                                    .cornerRadius(10)
                            }
                            .padding(15)
                            Spacer()
                        }
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            HStack {
                HStack(spacing: 10.0) {
                    Image.icnHeart
                    Image.icnComment
                    Image.icnShare
                }
                
                if(post.imagesUrl.count > 1) {
                    HStack(spacing: 3) {
                        ForEach(0..<post.imagesUrl.count, id: \.self) { index in
                            if index == _currentStep {
                                Rectangle()
                                    .frame(width: 7, height: 7)
                                    .clipShape(Circle())
                                    .foregroundColor(Color._3897F0)
                            } else {
                                Rectangle()
                                    .frame(width: 7, height: 7)
                                    .clipShape(Circle())
                                    .foregroundColor(Color._000000.opacity(0.15))
                            }
                        }
                    }
                    .padding(.leading, 60)
                }

                Spacer()

                Image.icnBookmark
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostRow(post: MockData.posts[0])
            PostRow(post: MockData.posts[1])
            PostRow(post: MockData.posts[2])
            PostRow(post: MockData.posts[3])
        }
    }
}
