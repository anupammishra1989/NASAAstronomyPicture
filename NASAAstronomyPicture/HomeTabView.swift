//
//  HomeTabView.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var favorites = Favorites()
    var body: some View {
        TabView {
            PictureOfTheDayView().tabItem {
                Label(home, systemImage: "house.fill")
            }
            MyFavoriteListingView().tabItem {
                Label(favorite, systemImage: "list.dash")
            }
        }.environmentObject(favorites)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
            .environmentObject(Favorites())
    }
}
