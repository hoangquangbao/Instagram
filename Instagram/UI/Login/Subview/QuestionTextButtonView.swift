import SwiftUI

struct QuestionTextButtonView: View {
    
    private var questionText: String
    private var actionText: String
    private var action: ()->()
    
    init(questionText: String, actionText: String, action: @escaping () -> Void) {
        self.questionText = questionText
        self.actionText = actionText
        self.action = action
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text(questionText)
                .font(.sfProTextRegular(12, relativeTo: .title1))
                .foregroundColor(Color.black.opacity(0.5))
            
            Button {
                action()
            } label: {
                Text(actionText)
                    .font(.sfProTextBold(12, relativeTo: .title1))
                    .foregroundColor(Color._262626)
            }
        }
    }
}
