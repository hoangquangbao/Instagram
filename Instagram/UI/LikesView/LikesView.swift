//
//  LikesView.swift
//  Instagram
//
//  Created by Tran Thuan on 17/10/2022.
//

import SwiftUI

struct LikesView: View {
    
    @State var selectedTab = Tabs.SecondTab
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Following")
                        .foregroundColor(selectedTab == .FirstTab ? Color._262626 : Color._000000.opacity(0.4))
                    if selectedTab == .FirstTab {
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.horizontal, 0)
                            .background(Color._262626)
                    } else {
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.horizontal, 0)
                            .background(Color._262626.opacity(0))
                    }
                    
                }
                .onTapGesture {
                    self.selectedTab = .FirstTab
                }
                Spacer()
                VStack {
                    Text("You")
                        .foregroundColor(selectedTab == .SecondTab ? Color._262626 : Color._000000.opacity(0.4))
                    if selectedTab == .SecondTab {
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.horizontal, 0)
                            .background(Color._262626)
                    } else {
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.horizontal, 0)
                            .background(Color._262626.opacity(0))
                    }
                }
                .onTapGesture {
                    self.selectedTab = .SecondTab
                }
                Spacer()
            }
            .padding(.bottom)
            .background(Color.fafafa.edgesIgnoringSafeArea(.all))
            
            Spacer()
            
            if selectedTab == .FirstTab {
                FirstTabView()
            } else if selectedTab == .SecondTab {
                SecondTabView()
            }
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}

struct FirstTabView : View {
    
    var body : some View {
        VStack {
            Text("FIRST TAB VIEW")
        }
    }
}

struct TestData: Identifiable {
    var id = UUID()
    var title: String
    var items: [String]
}


struct SecondTabView : View {
    
    let mygroups = [
        TestData(title: "New", items: ["1","2","3"]),
        TestData(title: "Today", items: ["A","B","C"]),
        TestData(title: "This Week", items: ["€","%","&"]),
        TestData(title: "This Month", items: ["€","%","&"])
    ]
    
    var body : some View {
        VStack(spacing: 0) {
            HStack() {
                Text("Follow Requests")
                    .padding(.leading, 20)
                Spacer()
            }
            List {
                ForEach(mygroups) { gr in
                    Section(header: Text(gr.title) ) {
                        ForEach(gr.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
        }
    }
}

enum Tabs {
    case FirstTab
    case SecondTab
}
