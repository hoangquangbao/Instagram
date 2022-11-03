//
//  NewStoryView.swift
//  Instagram
//
//  Created by lhduc on 01/11/2022.
//

import SwiftUI

struct NewStoryView: View {
    let user: User
    
    @StateObject var vm = NewStoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Text("New story")
                    .font(.system(size: 18))
                    .bold()
                HStack {
                    IconButton(imageIcon: Image(systemName: "xmark")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(Color._000000)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Upload").font(.subheadline)
                    }
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
            .padding(.top, 5)
            
            if let imageAttach = vm.imageAttach {
                ZStack(alignment: .topTrailing) {
                    SquareImageTab(images: [imageAttach] as! [UIImage], currentStep: .constant(0))
                    Button {
                        withAnimation {
                            vm.imageAttach = nil
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            
            Spacer()
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.templates, id: \.self) { template in
                        Button {
                            vm.selectTemplate(for: template)
                        } label: {
                            Image(template)
                                .resizable()
                                .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenWidth / 3)
                                .scaledToFill()
                                .cornerRadius(10)
                                .padding(5)
                                .background(self.getColorBorder(for: template))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.leading, AppStyle.defaultSpacing)
        }
    }
    
    func getColorBorder(for template: String) -> Color {
        guard let templateSelected = vm.templateSelected else {
            return Color.clear
        }
        
        if(templateSelected == template) {
            return Color.primary.opacity(0.7)
        }
        
        return Color.clear
    }
}

struct NewStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoryView(user: MockData.users[0])
    }
}
