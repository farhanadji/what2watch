//
//  FavoriteIcon.swift
//  what2watch
//
//  Created by Farhan Adji on 14/02/21.
//

import SwiftUI

struct FavoriteIcon: View {
    @Binding var isFavorite: Bool
    var isDetailView: Bool = false
    var body: some View {
        VStack {
            if isFavorite {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.red.opacity(0.8))
                    .overlay(
                        HStack {
                            Color.white.opacity(0.2)
                                .frame(width: 14, height: 28)
                            Spacer()
                        }
                    )
            } else {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.black.opacity(0.8))
            }
        }
        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.white)
        .clipShape(Circle())
        .shadow(color: isDetailView ? Color.black.opacity(0.2) : .clear, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}
