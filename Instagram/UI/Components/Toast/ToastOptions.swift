//
//  ToastOptions.swift
//  Instagram
//
//  Created by lhduc on 07/12/2022.
//

import SwiftUI

enum ToastAlignment {
    case top, bottom
}

struct ToastOptions {
    var title: String
    var color: Color? = Color.white
    var bgColor: Color? = Color(.systemBlue)
    var leadingIcon: Image?
    var trailingIcon: Image?
    var timeLeft: Double = 3
    var alignment: ToastAlignment = .top
    
    func toAlignment() -> Alignment {
        switch(self.alignment) {
        case .top:   return Alignment.top
        case.bottom: return Alignment.bottom
        }
    }
    
    func toAnimationEdge() -> Edge {
        switch(self.alignment) {
        case .top:   return Edge.top
        case.bottom: return Edge.bottom
        }
    }
}
