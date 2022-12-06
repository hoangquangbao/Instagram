//
//  CallView.swift
//  Instagram
//
//  Created by lhduc on 05/12/2022.
//

import SwiftUI

struct CallView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isMuted: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to the call!")
                .bold()
            Spacer()
            HStack {
                _micButton
                Spacer()
                _endCallButton
            }
            .padding()
        }
    }
}

private extension CallView {
    var _micButton: some View {
        Button {
            isMuted ? (isMuted = false) : (isMuted = true)
        } label: {
            Image(systemName: "mic.circle.fill")
                .font(.system(size: 64.0))
                .foregroundColor(isMuted ? Color.yellow : Color.blue)
                .padding()
        }
    }
    
    var _endCallButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "phone.circle.fill")
                .font(.system(size:64.0))
                .foregroundColor(.red)
                .padding()
        }
    }
}

struct CallView_Previews: PreviewProvider {
    static var previews: some View {
        CallView()
    }
}
