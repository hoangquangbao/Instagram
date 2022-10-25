//
//  AddPostView.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: NewPostViewModel
    @ObservedObject var photoVm = PhotoModel()
    
    @State var photosSelected = [UIImage]()
    @State var currentIndex = 0
    @State var isShowImageBottomSheet = true
    private var _gridColumns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    init(user: User) {
        vm = NewPostViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            _header
            
            ScrollView(showsIndicators: false) {
                VStack {
                    UserRow(user: vm.user)
                        .padding(.top)
                        .padding(.horizontal, AppStyle.defaultSpacing)
                    
                    TextEditorWithPlaceholder("What are you thinking about?", text: $vm.caption)
                        .padding(.horizontal, AppStyle.defaultSpacing)
                    
                    if(photosSelected.count > 0) {
                        SquareImageTab(images: vm.uiImageToImage(photosSelected), currentStep: $currentIndex)
                    }
                }
            }
            
            HStack {
                Button {
                    withAnimation(.linear) {
                        isShowImageBottomSheet.toggle()
                    }
                } label: {
                    ZStack(alignment: .topTrailing) {
                        Image.icnCollapse
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(isShowImageBottomSheet ? Color.ffffff : Color.primary)
                            .padding(10)
                            .background(isShowImageBottomSheet ? Color.primary : Color.semiText.opacity(0.3))
                            .clipShape(Circle())
                        Badge(
                            text: photosSelected.count.toString(),
                            foregroundColor: Color.background,
                            backgroundColor: Color.primary
                        )
                        .offset(y: -5)
                        .opacity((photosSelected.count > 0 && !isShowImageBottomSheet) ? 1 : 0)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("icn_camera_bold")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(AppStyle.storyLinearGradient)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
            
            ScrollView {
                LazyVGrid(columns: _gridColumns, spacing: 1.0) {
                    ForEach(photoVm.allPhotos, id: \.self) { photo in
                        Button {
                            withAnimation {
                                if(photosSelected.contains{ $0 == photo }) {
                                    photosSelected = photosSelected.filter { $0 != photo }
                                } else {
                                    photosSelected.append(photo)
                                }
                            }
                        } label: {
                            if (photosSelected.contains(photo)) {
                                ZStack(alignment: .topTrailing) {
                                    Image(uiImage: photo)
                                        .resizable()
                                        .frame(width: UIScreen.screenWidth / 4, height: UIScreen.screenWidth / 4)
                                        .aspectRatio(1, contentMode: .fill)
                                    Color.primary.opacity(0.5)
                                    Badge(
                                        text: photoVm.getOrderOf(photo: photo, in: photosSelected).toString(),
                                        foregroundColor: Color.white,
                                        backgroundColor: Color.blue,
                                        size: 12
                                    )
                                    .padding(5)
                                }
                            } else {
                                Image(uiImage: photo)
                                    .resizable()
                                    .frame(width: UIScreen.screenWidth / 4, height: UIScreen.screenWidth / 4)
                                    .aspectRatio(1, contentMode: .fill)
                            }
                        }
                    }
                }
                .alert(isPresented: .constant(self.photoVm.errorString != "") ) {
                    Alert(title: Text("Error"), message: Text(self.photoVm.errorString ), dismissButton: Alert.Button.default(Text("OK")))
                }
            }
            .frame(height: isShowImageBottomSheet ? _getBottomSheetHeight() : 0)
            
            Spacer()
        }
    }
    
    private func _getBottomSheetHeight() -> CGFloat {
        let imageLength = photoVm.allPhotos.count
        if(imageLength > 0 && imageLength <= 4) {
            return UIScreen.screenWidth / 4
        }
        else if(imageLength <= 8) {
            return UIScreen.screenWidth / 2
        }
        
        return UIScreen.screenWidth
    }
}

struct CircleIconButton: View {
    let icon: Image
    var size: CGFloat = 20
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            icon
                .renderingMode(.template)
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(Color.primary)
                .padding(10)
                .background(Color.semiText.opacity(0.25))
                .clipShape(Circle())
        }
    }
}

extension NewPostView {
    var _header: some View {
        ZStack(alignment: .center) {
            Text("New post")
                .font(.system(size: 18))
                .bold()
            HStack {
                IconButton(imageIcon: Image(systemName: "xmark")) {
                    dismiss()
                }
                .font(.subheadline)
                .foregroundColor(Color._000000)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Continue").font(.subheadline)
                }
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
}

extension Int {
    func toString() -> String{
        return String(self)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(user: MockData.users[0])
    }
}
