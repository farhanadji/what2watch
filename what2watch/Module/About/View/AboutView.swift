//
//  AboutView.swift
//  what2watch
//
//  Created by Farhan Adji on 11/02/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(systemName: "tv.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.black)
                    .overlay(
                        Text("W2W")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .offset(y: -5)
                    )
                
                Text("What2Watch")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text("2021")
                    .foregroundColor(Color.black.opacity(0.5))
            }
            
            Divider()
            
            HStack(spacing: 10) {
                Image("me")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                
                VStack(alignment: .leading) {
                    
                    Text("Farhan Adji")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                    
                    Text("iOS Developer")
                    
                    Text("farhanadji@live.com")
                        .foregroundColor(Color.black.opacity(0.5))
                    
                }
                Spacer(minLength: 10)
            }
            
            Spacer()
            Spacer()
        }
        .padding()
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
