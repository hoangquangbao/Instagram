import SwiftUI

struct EditFieldView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Update fields...")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit field")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.appPrimary)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct EditFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EditFieldView()
    }
}
