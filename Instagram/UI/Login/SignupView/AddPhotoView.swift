import SwiftUI

@available(iOS 16.0, *)
struct AddPhotoView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    Group {
                        Text("Add profile photo")
                            .font(.sfProTextBold(22, relativeTo: .largeTitle))
                            .padding(.top, 50)
                        
                        Text("Add a profile photo so your friend know it's you.")
                            .font(.sfProTextRegular(13, relativeTo: .caption1))
                            .foregroundColor(Color.black.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle.badge.plus")
                            .fontWeight(.ultraLight)
                            .font(.system(size: 120))
                            .foregroundStyle(
                                AngularGradient(colors: [.purple, .red, .yellow, .black], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270))
                            )
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
                    Divider()
                    
                    Group {
                        Button {
                        } label: {
                            Text("Add a photos")
                        }
                        .buttonStyle(CustomButtonStyle())
                        
                        Button {
                        } label: {
                            Text("Skip")
                                .font(.sfProTextBold(16, relativeTo: .caption1))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView()
    }
}
