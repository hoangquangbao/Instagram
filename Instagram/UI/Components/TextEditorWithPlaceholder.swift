//
//  TextEditorWithPlaceholder.swift
//  Instagram
//
//  Created by lhduc on 19/10/2022.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    private var _placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        _placeholder = placeholder
        _text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(_placeholder)
                        .font(.subheadline)
                        .foregroundColor(Color.appPrimary)
                        .padding(.top, 10)
                        .padding(.leading, 6)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .font(.subheadline)
                    .foregroundColor(Color.appPrimary)
                    .opacity(text.isEmpty ? 0.65 : 1)
                Spacer()
            }
        }
    }
}

struct TextEditorWithPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorWithPlaceholder("What do you think about?", text: .constant(""))
    }
}

