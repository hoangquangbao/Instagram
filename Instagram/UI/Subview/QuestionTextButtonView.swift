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
                .font(.sfProTextRegular(11, relativeTo: .title1))
                .foregroundColor(Color._000000.opacity(0.4))
            
            Button {
                action()
            } label: {
                Text(actionText)
                    .font(.sfProTextBold(11, relativeTo: .title1))
                    .foregroundColor(Color._262626)
            }
        }
    }
}
