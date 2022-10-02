//
//  UIMainView.swift
//  Instagram
//
//  Created by Tran Thuan on 20/09/2022.
//

import SwiftUI

import SwiftUI

struct UIMainView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Header()
            
            ScrollView(.vertical, showsIndicators: false) {
                Stories()
                
                Divider()
                
                Post()
                
                Post(image: Image.imgDog, description: "I love her, almost 2 years old")
            }
            
            TabBar()
        }
    }
}

struct UIMainView_Previews: PreviewProvider {
    static var previews: some View {
        UIMainView()
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Image.imgInstagramLogo
            
            Spacer()
            
            HStack(alignment: .center, spacing: 20.0) {
                Image.icnAdd
                Image.icnHeart
                Image.icnHeart
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 3)
    }
}

struct Story: View {
    var image: Image = Image.imgProfile
    var name: String = "Willie Yam"
    
    var body: some View {
        VStack {
            VStack {
                image
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
            
            Text(name)
                .font(.caption)
        }
    }
}

struct Stories: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15.0) {
                Story(image: Image.imgProfile, name: "Willie Yam")
                Story(image: Image.imgProfile2, name: "Meng")
                Story(image: Image.imgProfile3, name: "Akson")
                Story(image: Image.imgProfile4, name: "Steph")
                Story(image: Image.imgProfile5, name: "Sam")
                Story(image: Image.imgProfile6, name: "Dara")
                Story(image: Image.imgProfile7, name: "Sourany")
                Story(image: Image.imgProfile8, name: "Pom")
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 10)
    }
}

struct PostHeader: View {
    var body: some View {
        HStack {
            HStack(spacing: 9.0) {
                Image.imgProfile
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(50)
                
                Text("Willie Yam")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Image.icnMore
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
}

struct PostContent: View {
    
    @State var currentStep = 0
    var image: Image = Image.imgProfile
    var listImage: [Image] = [Image.imgProfile,Image.imgProfile2,Image.imgProfile3]
    
    var body: some View {
        VStack {
            TabView(selection: $currentStep) {
                ForEach(0..<listImage.count, id: \.self) { item in
                    ZStack() {
                        HStack() {
                            listImage[item]
                                .resizable()
                                .frame(width: .infinity)
                                .scaledToFit()
                        }
                        VStack(alignment: .leading) {
                            HStack() {
                                Spacer()
                                HStack() {
                                    Text(String(item+1)) + Text("/3")
                                }
                                .padding(7)
                                    .background(Color(hex: 0x121212, alpha: 0.7))
                                    .foregroundColor(Color(hex: 0xF9F9F9))
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
                    ForEach(0..<listImage.count, id: \.self) { item in
                        if item == currentStep {
                            Rectangle()
                                .frame(width: 10, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0x3897F0))
                        } else {
                            Rectangle()
                                .frame(width: 10, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(Color(hex: 0x000000,alpha: 0.15))
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

struct Post: View {
    var image: Image = Image.imgProfile
    var description: String = "I miss traveling to Japan"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            PostHeader()
            
            PostContent(image: image)
            
            Text("Liked by Meng To and others")
                .font(.footnote)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            
            Text(description)
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
                
                HStack(alignment: .center) {
                    Text("😍")
                    Text("😂")
                    Image(systemName: "plus.circle")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct TabBar: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Divider()
            
            HStack {
                Image.icnHome
                Spacer()
                Image.icnSearch
                Spacer()
                Image.icnReels
                Spacer()
                Image.icnShop
                Spacer()
                Image.imgProfile
                    .resizable()
                    .frame(width: 21, height: 21)
                    .cornerRadius(50)
            }
            .padding(.top, 10)
            .padding(.horizontal, 25)
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
