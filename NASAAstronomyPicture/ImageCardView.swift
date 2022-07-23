//
//  ImageCardView.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 22/07/22.
//

import SwiftUI

struct ImageCardView: View {
    
    @Binding var pictureOfDay: PictureOfDay
    var height: Double = 300.0
    var width: Double = UIScreen.main.bounds.width
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        VStack {
            HStack {
                Text(pictureOfDay.title ?? "")
                    .font(.title)
                Spacer()
            }
            HStack {
                let dateStr = pictureOfDay.date?.toDate()?.toString() ?? ""
                Text(dateStr)
                    .font(.subheadline)
                Spacer()
            }
            VStack(alignment: .center) {   //load avatar
                AsyncImage(url: URL(string: pictureOfDay.url ?? ""), scale: 1) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    //  .frame(width: width * 0.9, height: height)
                    
                    //Favorites button
                    Button(favorites.contains(pictureOfDay) ? removeFromFavoritesText : addToFavorites) {
                        if favorites.contains(pictureOfDay) {
                            favorites.remove(pictureOfDay)
                        } else {
                            favorites.add(pictureOfDay)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } placeholder: { ProgressView().progressViewStyle(.circular) }
                
            }.padding(.bottom, 5)
            HStack {
                Text(pictureOfDay.explanation ?? "")
                Spacer()
            }
            Spacer()
        }.cornerRadius(10)
            .padding()
    }
}

struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardView(pictureOfDay: .constant(PictureOfDay()))
    }
}
