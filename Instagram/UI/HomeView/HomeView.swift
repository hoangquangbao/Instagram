//
//  HomeView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct HomeView: View {
    
    var _listImage: [String] = ["img_profile","img_profile2","img_profile3"]
    @State var _currentStep = 0
    
    var body: some View {
        VStack(spacing: 0.0) {
            Header()
            
            ScrollView(.vertical, showsIndicators: false) {

                ListStories()
                
                Divider()
                
                PostPage(description: "Beautiful")
                PostPage(description: "Beautiful")
                PostPage(description: "Beautiful")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    private func Header() -> some View {
        HStack {
            Image.icnLogo
            
            Spacer()
            
            HStack(alignment: .center, spacing: 20.0) {
                Image.icnAdd
                Image.icnHeart
                Image.icnMessenger
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 3)
    }
    
    private func ListStories() -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15.0) {
                ItemStory(image: "img_profile", name: "Willie Yam")
                ItemStory(image: "img_profile2", name: "Meng")
                ItemStory(image: "img_profile3", name: "Akson")
                ItemStory(image: "img_profile4", name: "Steph")
                ItemStory(image: "img_profile5", name: "Sam")
                ItemStory(image: "img_profile6", name: "Dara")
                ItemStory(image: "img_profile7", name: "Sourany")
                ItemStory(image: "img_profile8", name: "Pom")
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 10)
    }
    
    private func ItemStory(image: String?, name: String?) -> some View {
        VStack {
            VStack {
                Image(image ?? "")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(50)
            }
            .overlay(
                Circle()
                    .stroke(LinearGradient(colors: [.red, .purple, .red, .orange, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.3)
                    .frame(width: 68, height: 68)
            )
            .frame(width: 70, height: 70)
            
            Text(name ?? "")
                .font(.caption)
        }
    }
    
    private func PostPage(description: String?) -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            PostHeader()
            
            PostContent()
            
            Text("Liked by Meng To and others")
                .font(.footnote)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            
            Text(description ?? "")
                .font(.footnote)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            
            HStack {
                HStack(spacing: 7.0) {
                    Image.imgProfile
                        .resizable()
                        .frame(width: 24, height: 24)
                        .cornerRadius(50)
                    
                    Text("Add comment...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 9)
                
                Spacer()
                
//                HStack(alignment: .center) {
//                    Text("😍")
//                    Text("😂")
//                    Image(systemName: "plus.circle")
//                        .foregroundColor(.secondary)
//                }
            }
        }
    }
    
    private func PostHeader() -> some View {
        HStack {
            HStack(spacing: 9.0) {
                Image.imgProfile
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(50)
                
                VStack(alignment: .leading) {
                    Text("Willie Yam")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("Viet Nam")
                        .font(.caption)
                        .fontWeight(.light)
                }
            }
            
            Spacer()
            
            Image.icnMore
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
    
    private func PostContent() -> some View {
        VStack {
            TabView(selection: $_currentStep) {
                ForEach(0..<_listImage.count, id: \.self) { item in
                    ZStack() {
                        HStack() {
                            Image(_listImage[item])
                                .resizable()
                                .frame(width: .infinity)
                                .scaledToFit()
                        }
                        VStack(alignment: .leading) {
                            HStack() {
                                Spacer()
                                HStack() {
                                    Text(String(item+1))
                                        .font(.system(size: 12)) + Text("/3").font(.system(size: 12))
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
                    .tag(item)
                }
            }
            .frame(width: .infinity, height: 400)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            HStack {
                HStack(spacing: 10.0) {
                    Image.icnHeart
                    Image.icnComment
                    Image.icnShare
                }
                HStack() {
                    ForEach(0..<_listImage.count, id: \.self) { item in
                        if item == _currentStep {
                            Rectangle()
                                .frame(width: 10, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(Color._3897F0)
                        } else {
                            Rectangle()
                                .frame(width: 10, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(Color._000000.opacity(0.15))
                        }
                    }
                }.padding(.leading, 60)

                Spacer()

                Image.icnBookmark
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
        }
    }
}


