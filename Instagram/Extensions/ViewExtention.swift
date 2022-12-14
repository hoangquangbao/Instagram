//
//  ViewExtention.swift
//  Instagram
//
//  Created by lhduc on 07/12/2022.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension View {
    func showWaitingDialog(title: String, isLoading: Binding<Bool>) -> some View {
        modifier(CustomWaitingDialog(title: title, isLoading: isLoading))
    }
}

extension View {
    func showToast(toastOption: ToastOptions, isPresent: Binding<Bool>) -> some View {
        modifier(DefaultToast(toastOptions: toastOption, isPresent: isPresent))
    }
}

extension View {
    func shimmeringStyle(shape: ShimmerShapeType = .rectangle) -> some View {
        modifier(DefaultShimmering(shape: shape))
    }
}
