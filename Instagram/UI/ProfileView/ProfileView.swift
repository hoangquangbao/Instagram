//
//  ProfileView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService: SessionService
    
    // MARK:- PROPERTIES
    
    init(){
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    @State private var _bottomSheetShown = false
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
                        Text(sessionService.userInfo?.username ?? "")
                            .font(Font.system(size: 22, weight: .bold))
                    }//: TOOLBAR ITEM LEFT
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:{
                            _bottomSheetShown.toggle()
                        }){
                            Image.icnBurger
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                        }
                    }//: TOOLBAR ITEM RIGHT
                }
            }//: NAVIGATION
            
            if _bottomSheetShown {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        _bottomSheetShown.toggle()
                    }
            }
            
            GeometryReader { geometry in
                BottomSheetView(
                    isOpen: self.$_bottomSheetShown,
                    maxHeight: geometry.size.height * 0.7
                ) {
                    SettingsView()
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

// MARK:- PREVIEW

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
        
    func UserProfileView() -> some View {
        VStack(alignment: .center, spacing: 0){
            VStack(alignment: .leading){
                UserInfoView()
                Text(sessionService.userInfo?.username ?? "")
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.top, 5)
                    .padding(.bottom, 1)
                Text("Digital goodies designer @pixsellz \n Everything is designed.")
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
                AsyncImage(url: URL(string: sessionService.userInfo?.avatarUrl ?? ""))
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
                    Text("54")
                        .font(Font.system(size: 17, weight: .medium))
                    Text("Posts")
                        .font(.footnote)
                }//: VSTACK
                
                VStack(alignment: .center, spacing: 0){
                    Text("834")
                        .font(Font.system(size: 17, weight: .medium))
                    Text("Followers")
                        .font(.footnote)
                }//: VSTACK
                
                VStack(alignment: .center, spacing: 0){
                    Text("162")
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
            }//: HSTACK
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
                ForEach(data) { item in
                    Image(item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: (UIScreen.main.bounds.width - 8) / 3)
                        .clipped()
                }//: LOOP
            }//: GRID
        }
        
    }
    
    func SettingsView() -> some View {
        ScrollView(.vertical, showsIndicators:false) {
            ForEach(SettingListData){ item in
                VStack(alignment: .leading){
                    HStack(alignment: .center, spacing: 15){
                        Image(item.image)
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



