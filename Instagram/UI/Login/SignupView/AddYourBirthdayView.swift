import SwiftUI

struct AddYourBirthdayView: View {
    
    @State private var _selectedDate: Date = Date.now
    @State private var _isShowAge: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    Image.imgBirthday
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                    
                    Text("Add your birthday")
                        .font(.sfProTextBold(22, relativeTo: .largeTitle))
                    
                    VStack(spacing: 5) {
                        Text("This won't be part of your public profile.")
                            .foregroundColor(Color.black.opacity(0.8))
                        
                        Text("Why I need to provide my birthday?")
                            .foregroundColor(Color.blue.opacity(0.8))
                            .onTapGesture {
                                
                            }
                    }
                    .font(.sfProTextRegular(15, relativeTo: .caption1))
                    .lineSpacing(3)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    HStack {
                        Text(setDateString(selectedDate: _selectedDate))
                            .font(.sfProTextRegular(15, relativeTo: .caption1))
                            .foregroundColor(Color.black.opacity(_isShowAge ? 1 : 0.5))
                        
                        Spacer()
                        
                        if _isShowAge {
                            Text(String(_selectedDate.age) + " years old")
                                .font(.sfProTextRegular(13, relativeTo: .caption1))
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                    }
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5), lineWidth: 0.5)
                    }
                    .background {
                        Color.white
                    }
                    .cornerRadius(5)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                Text("Use your own birthday, even if this account is for a business, a pet or something else.")
                    .font(.sfProTextRegular(13, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Divider()
                Group {
                    Button {
                    } label: {
                        Text("Next")
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    DatePicker("", selection: $_selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.top, -30)
                        .padding(.bottom, -120)
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .onChange(of: _selectedDate) { newValue in
                            _isShowAge = true
                        }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension AddYourBirthdayView {
    
    private func setDateString(selectedDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
}

extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}

struct AddYourBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddYourBirthdayView()
    }
}
