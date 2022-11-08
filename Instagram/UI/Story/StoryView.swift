//
//  StoryView.swift
//  Instagram
//
//  Created by lhduc on 05/11/2022.
//

import SwiftUI
import Kingfisher

struct StoryView: View {
    @EnvironmentObject var storyVm: StoryViewModel
    
    @State private var currentProgress = 0.0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if storyVm.activeStories.isNotEmpty {
                ZStack(alignment: currentStory.getTextAlignment()) {
                    _imageBackground
                    _caption
                }

                VStack {
                    _timeProgressIndicators

                    _header

                    _invisibleLayerForChangeStory
                    
                }
                .padding(.horizontal, AppStyle.defaultSpacing)
            }
        }
        .background(Color.black)
        .onTapGesture(perform: storyVm.clear)
        .onReceive(timer) { _ in _increaseProgressValue() }
        .transition(.opacity)
    }
    
    var currentStory: Story {
        let activeStories: [Story] = storyVm.activeStories
        return activeStories[min(Int(currentProgress), activeStories.count - 1)]
    }
}

private extension StoryView {
    var _timeProgressIndicators: some View {
        HStack(spacing: 5) {
            ForEach(0..<storyVm.activeStories.count, id: \.self) { index in
                GeometryReader { proxy in
                    let progress = currentProgress - CGFloat(index)
                    let perfectProgress = min(max(progress, 0), 1)

                    _CustomLinearIndicator(width: proxy.size.width * perfectProgress)
                }
            }
        }
        .frame(height: 2.5)
        .padding(.top)
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _imageBackground: some View {
        GeometryReader { proxy in
            KFImage(URL(string: currentStory.imagesUrl))
                .resizable()
//                .frame(width: proxy.size.width, height: proxy.size.height)
                .aspectRatio(proxy.size, contentMode: .fill)
                .cornerRadius(5, corners: .allCorners)
        }
    }
    
    var _header: some View {
        HStack {
            if let user = currentStory.user {
                UserRow(user: user)
            }
            
            Spacer()
            
            Button {
                storyVm.clear()
            } label: {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.white)
                
            }
        }
        .padding(.top, 5)
    }
    
    var _invisibleLayerForChangeStory: some View {
        GeometryReader { proxy in
            HStack {
                Color.clear.contentShape(Rectangle()).onTapGesture(perform: self.previous)
                Color.clear.contentShape(Rectangle()).onTapGesture(perform: self.next)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    var _caption: some View {
        Text(currentStory.caption)
            .font(.title)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(currentStory.captionColorHex))
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
    }
}

private extension StoryView {
    func _increaseProgressValue() {
        withAnimation {
            if(currentProgress >= CGFloat(storyVm.activeStories.count)) {
                storyVm.clear()
            } else {
                self.currentProgress += 0.01
            }
        }
    }
    
    func next() {
        if Int(currentProgress) < storyVm.activeStories.count - 1 {
            self.currentProgress = (self.currentProgress + 1).rounded(.towardZero)
        } else {
            storyVm.clear()
        }
    }
    
    func previous() {
        if Int(currentProgress) >= 1 {
            self.currentProgress = (self.currentProgress - 1).rounded(.towardZero)
        } else {
            storyVm.clear()
        }
    }
}

private struct _CustomLinearIndicator: View {
    let width: CGFloat
    
    var body: some View {
        Capsule()
            .fill(.gray.opacity(0.5))
            .overlay(alignment: .leading) {
                Capsule().fill(.white).frame(width: width)
            }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
            .environmentObject(StoryViewModel())
    }
}
