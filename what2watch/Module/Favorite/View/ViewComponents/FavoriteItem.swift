//
//  FavoriteItem.swift
//  what2watch
//
//  Created by Farhan Adji on 12/02/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core

struct FavoriteItem: View {
    var movie: Movie
    var removeAction: (() -> Void)
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            WebImage(url: URL(string: movie.posterPath))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Text(movie.releaseDate)
                    .font(.system(size: 16))
                    .foregroundColor(Color.black.opacity(0.6))
                Spacer()
            }
            
            Spacer(minLength: 5)
            
            Button(action: {
                removeAction()
            }) {
                FavoriteIcon(isFavorite: .constant(true))
            }
        }
        .frame(height: 80)
        .padding(.horizontal)
        
    }
}
