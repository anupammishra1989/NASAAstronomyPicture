//
//  MyFavoriteListingView.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

import SwiftUI

struct MyFavoriteListingView: View {
    
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer().frame(height: 20)
                
                ForEach (favorites.pictures, id: \ .url) { picture in
                    VStack {
                        ImageCardView(pictureOfDay: .constant(picture))
                    }.padding(.top, 10)
                        .padding(.bottom, 10)
                    Divider()
                }
            }
            .navigationTitle(myFavoritesListingsText)
            .toolbar {
                Button(clearAll) {
                    favorites.removeAll()
                }
            }
            .onAppear {
            }
        }
    }
}

struct MyFavoriteListingView_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteListingView()
    }
}
