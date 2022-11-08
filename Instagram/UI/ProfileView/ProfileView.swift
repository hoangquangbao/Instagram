//
//  ProfileView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    var user: User?
    @EnvironmentObject var sessionVm: SessionViewModel
    @EnvironmentObject var postVm: PostViewModel
    
    // MARK:- PROPERTIES
    
    init(user: User?) {
        if let user = user { self.user = user }
        else { self.user = self.sessionVm.userInfo }
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    @State private var _isShowBottomSheet = false
    @State private var _isShowDetailOption = false
    @State private var _title: String = ""
    
    let _gridLayout:[GridItem] =  Array(repeating: .init(.flexible(), spacing:2), count: 3)
    
    // MARK:- BODY
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .center, spacing: 0) {
                        UserProfileView()
                        HighlightView(data: HighlightData)
                        PostGridView(data: ProfilePostData, gridLayout: _gridLayout)
                            .padding(.horizontal, 2)
                    }//: VSTACK
                }//: SCROLL
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(user?.username ?? "")
                            .font(Font.system(size: 22, weight: .bold))
                    }//: TOOLBAR ITEM LEFT
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:{
                            _isShowBottomSheet.toggle()
                        }){
                            Image.icnBurger
                                .resizable()
                                .scaledToFill()
                                .frame(width: 22, height: 22)
                        }
                    }//: TOOLBAR ITEM RIGHT
                }
            }//: NAVIGATION
            
            if _isShowBottomSheet {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        _isShowBottomSheet.toggle()
                    }
            }
            
            if _isShowDetailOption {
                SettingView(isShowDetailOption: $_isShowDetailOption, title: _title)
                    .transition(.move(edge: .trailing))
            }
            
            GeometryReader { geometry in
                BottomSheetView(
                    isOpen: self.$_isShowBottomSheet,
                    maxHeight: geometry.size.height * 0.7
                ) {
                    OptionsView(bottomSheetShow: $_isShowBottomSheet, isShowDetailOption: $_isShowDetailOption, title: $_title)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

// MARK:- PREVIEW

@available(iOS 16.0, *)
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: MockData.users[0])
    }
}

extension ProfileView {
        
    func UserProfileView() -> some View {
        VStack(alignment: .center, spacing: 0){
            VStack(alignment: .leading){
                UserInfoView()
                Text(user?.fullName ?? "")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.top, 5)
                    .padding(.bottom, 1)
                Text("Digital goodies designer @pixsellz \nEverything is designed.")
                    .font(Font.system(size: 13, weight: .regular))


                    .foregroundColor(Color._262626)
                ProfileActionsView()
                    .padding(.top, 10)
            }//: VSTACK
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
    
    func UserInfoView() -> some View {
        HStack(alignment: .center){
            ZStack{
                KFImage(URL(string: user?.avatarUrl ?? ""))
//                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 25, height: 25)
                    
                    Image(systemName: "plus")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                    Circle().stroke(Color.white, lineWidth: 2)
                        .frame(width: 25, height: 25)
                }
                .offset(x: 35, y: 30)
            }//: ZSTACK
            
            Spacer()
            
            HStack(alignment: .center, spacing:30){
                VStack(alignment: .center, spacing: 0){
                    Text(postVm.getOwningPost(withUid: user?.id ?? "").count.toString())
                        .font(Font.system(size: 17, weight: .medium))
                    Text("Posts")
                        .font(.footnote)
                }//: VSTACK
                
                VStack(alignment: .center, spacing: 0){
                    Text(user?.followers.count.toString() ?? "")
                        .font(Font.system(size: 17, weight: .medium))
                    Text("Followers")
                        .font(.footnote)
                }//: VSTACK
                
                VStack(alignment: .center, spacing: 0){
                    Text(user?.followings.count.toString() ?? "")
                        .font(Font.system(size: 17, weight: .medium))
                    Text("Following")
                        .font(.footnote)
                }//: VSTACK
            }//: HSTACK
            Spacer()
                .frame(width: 20)
        }//: HSTACK
    }
    
    func ProfileActionsView() -> some View {
        VStack(alignment: .center, spacing: 8){
            HStack(alignment: .center, spacing: 8){
                Button(action:{
                    print("edit profile")
                }){
                    Text("Edit Profile")
                        .font(Font.system(size: 13, weight: .medium))
                        .padding(.vertical, 9)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color(red: 210/255, green: 210/255, blue: 210/255), lineWidth: 0.7)
                        )
                }
            }//: HSTACK
        }//: VSTACK
    }
    
    func HighlightView(data: Array<HighlightDataModel>) -> some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 10){
                ForEach(data) { item in
                    VStack(alignment: .center, spacing: 8){
                        ZStack {
                            Image(item.cover)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 58, height: 58, alignment: .center)
                                .clipShape(Circle())
                            
                            Circle().stroke(Color(red: 220/255, green: 220/255, blue: 220/255) , style: StrokeStyle(lineWidth: 1, lineCap: .round))
                                .frame(width: 68, height: 68, alignment: .center)
                        }//: ZSTACK
                    
                        Text(item.name)
                            .lineLimit(1)
                            .font(Font.system(size: 12, weight: .regular))
                            .frame(width: 75)
                            .foregroundColor(.primary)
                    }//: VSTACK
                }//: LOOP
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }//: SCROLL
    }
    
    func PostGridView(data: Array<ProfilePostModel>, gridLayout: Array<GridItem>) -> some View {
        VStack(spacing: 1) {
            HStack() {
                Button(action: {
                      print("button gird")

                    }) {
                        VStack() {
                            Image.icnGridPf
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            Divider()
                             .frame(height: 1)
                             .background(Color._262626)
                        }
                    }
                    .frame(maxWidth: .infinity)
                Button(action: {
                      print("button phonebook")

                    }) {
                        VStack() {
                            Image.icnPhonebook
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                    }
                    .frame(maxWidth: .infinity)
            }
            LazyVGrid(columns: gridLayout, spacing:2){
                ForEach(postVm.getOwningPost(withUid: user?.id ?? "")) { post in
                    KFImage(URL(string: post.imagesUrl[0]))
                        .resizable()
                        .scaledToFill()
                        .frame(height: (UIScreen.main.bounds.width - 8) / 3)
                        .clipped()
                }
            }
        }
        
    }
    
    func SettingsView() -> some View {
        ScrollView(.vertical, showsIndicators:false) {
            ForEach(SettingListData){ item in
                VStack(alignment: .leading){
                    HStack(alignment: .center, spacing: 15){
                        Image("\(item.image)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        Text(item.title)
                            .font(Font.system(size: 17, weight: .regular))
                    }//: HSTACK
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    Divider()
                        .padding(.leading, 50)
                }//: VSTACK
            }//: LOOP
        }//: SCROLL
        .background(Color.white)
    }
}



