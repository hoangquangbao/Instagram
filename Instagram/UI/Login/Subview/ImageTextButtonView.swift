import SwiftUI

struct ImageTextButtonView: View {
    
    private var icon: Image
    private var text: String
    private var action: ()->()
    
    init(icon: Image, text: String, action: @escaping () -> Void) {
        self.icon = icon
        self.text = text
        self.action = action
    }
    
    var body: some View {
        
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 4) {
                icon
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(text)
            }
        }
    }
}
