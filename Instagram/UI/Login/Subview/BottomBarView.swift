import SwiftUI

struct BottomBarView: View {
    
    private var questionText: String?
    private var actionText: String
    private var action: ()->Void
    
    init(questionText: String? = nil,
         actionText: String,
         action: @escaping () -> Void) {
        self.questionText = questionText
        self.actionText = actionText
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(alignment: .center, spacing: 4) {
                Text(questionText ?? "")
                    .font(.sfProTextRegular(13, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.5))
                
                Button {
                    action()
                } label: {
                    Text(actionText)
                        .font(.sfProTextSemibold(13, relativeTo: .caption1))
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
}
