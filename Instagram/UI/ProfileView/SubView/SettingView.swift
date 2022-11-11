import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var vmLogin: LoginViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    
    @State private var _isShowLogoutDialog = false
    
    @Binding var isShowDetailOption: Bool
    var title: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    VStack {
                        ///Add some funcs in here
                        HStack {
                            Button {
                                _isShowLogoutDialog.toggle()
                            } label: {
                                Text("Log out")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(Text(title))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowDetailOption.toggle()
                    } label: {
                        Image.icnBack
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .confirmationDialog("Log out?",
                                isPresented: $_isShowLogoutDialog,
                                titleVisibility: .visible,
                                actions: {
                Button("Log out", role: .destructive) {
                    vmLogin.handleLogout { result in
                        perform.isBackLoginView = result
                    }
                }
                Button("Cancel", role: .cancel) {}
            })
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isShowDetailOption: .constant(false), title: "Setting")
    }
}
