//
//  ProfileView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

@available(iOS 16.0, *)
struct ProfileView: View {
    
    // MARK:- PROPERTIES
    
    init(){
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
                        Text("jacob_w")
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
                        //                        HStack(alignment: .center, spacing: 20){
                        //                            Button(action:{
                        //                                bottomSheetShown.toggle()
                        //                            }){
                        //                               Image("add2")
                        //                                .resizable()
                        //                                .scaledToFill()
                        //                                .frame(width: 22, height: 22)
                        //                            }
                        //                        }
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
        ProfileView()
    }
}

