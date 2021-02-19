//
//  TabButton.swift
//  what2watch
//
//  Created by Farhan Adji on 12/02/21.
//

import SwiftUI

struct TabButton: View {
    private var title: String
    private var image: String
    private var tab: Tab
    @Binding var selected: Tab
    
    init(forTab: Tab, selected: Binding<Tab>) {
        self.tab = forTab
        self._selected = selected
        switch forTab {
        case .home:
            title = "Home"
            image = "house"
        case .favorite:
            title = "Favorite"
            image = "heart.circle"
        case .profile:
            title = "About"
            image = "person.circle"
        }
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()){
                selected = tab
            }
        }) {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.black)
                
                if selected == tab {
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(selected == tab ? Color.black.opacity(0.10) : Color.clear)
            .clipShape(Capsule())
        }
    }
}
