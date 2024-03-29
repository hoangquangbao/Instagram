//
//  ProfileView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    let user: User
    @StateObject var vm = ProfileViewModel()
    @State private var _selectedIndex: Int = 0
    
    @EnvironmentObject var sessionVm: SessionViewModel
    @EnvironmentObject var postVm: PostViewModel
    
    init(user: User) {
        self.user = user
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .center, spacing: 0) {
                        UserProfileView(user: user, postCount: postVm.getOwningPost(of: user).count, isShowEditProfile: $vm.isShowEditProfile)
                        _highlightView(data: highlightData)
                        SegmentedPickerView(titles: vm.pickerImages,
                                            selectedIndex: $_selectedIndex)
                        if _selectedIndex == 0 {
                            _owningPost
                        } else {
                            _owningContact
                        }
                    }
                    .fullScreenCover(isPresented: $vm.isShowEditProfile) {
                        EditProfileView(user: user)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(user.username) .font(Font.system(size: 22, weight: .bold))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if sessionVm.uid == user.id {
                            Button {
                                vm.isShowBottomSheet.toggle()
                            } label: {
                                Image.icnBurger
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color.primary)
                                    .scaledToFill()
                                    .frame(width: 22, height: 22)
                            }
                        }
                    }
                }
            }
            
            if vm.isShowBottomSheet {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        vm.isShowBottomSheet.toggle()
                    }
            }
            
            if vm.isShowDetailOption {
                SettingView(isShowDetailOption: $vm.isShowDetailOption, title: vm.title)
                    .transition(.move(edge: .trailing))
            }
            
            GeometryReader { geometry in
                BottomSheetView(
                    isOpen: self.$vm.isShowBottomSheet,
                    maxHeight: geometry.size.height * 0.5
                ) {
                    OptionsView(bottomSheetShow: $vm.isShowBottomSheet, isShowDetailOption: $vm.isShowDetailOption, title: $vm.title)
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .environmentObject(vm)
    }
}

// MARK:- PREVIEW
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: MockData.users[0])
    }
}

private extension ProfileView {
    func _highlightView(data: Array<Highlight>) -> some View {
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
                        }
                        
                        Text(item.name)
                            .lineLimit(1)
                            .font(Font.system(size: 12, weight: .regular))
                            .frame(width: 75)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
    
    var _owningPost: some View {
        VStack(spacing: 2) {
            PostImageGridLayout(posts: postVm.getOwningPost(of: user))
        }
        .padding(.horizontal, 2)
    }
    
    var _owningContact: some View {
        VStack(spacing: 5) {
            Text("Photos and videos of you")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.appPrimary)
            
            Text("When people tag you in photos and videos, they'll appear here")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.semiText)
                .multilineTextAlignment(.center)
        }
        .padding(50)
    }
    
    func _settingsView() -> some View {
        ScrollView(.vertical, showsIndicators:false) {
            ForEach(settingListData){ item in
                VStack(alignment: .leading){
                    HStack(alignment: .center, spacing: 15){
                        Image("\(item.image)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                        Text(item.title)
                            .font(Font.system(size: 17, weight: .regular))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    Divider()
                        .padding(.leading, 50)
                }
            }
        }
        .background(Color.white)
    }
}



