//
//  ProfileView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct ProfileView: View {
    
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
                        Text("jacob_w")
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

