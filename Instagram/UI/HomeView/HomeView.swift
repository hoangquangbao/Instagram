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
                
                ForEach(MockData.posts) { post in
                    PostRow(post: post)
                }
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
}


