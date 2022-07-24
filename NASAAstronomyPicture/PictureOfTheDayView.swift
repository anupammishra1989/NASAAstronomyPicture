//
//  PictureOfTheDayView.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

import SwiftUI

struct PictureOfTheDayView: View {
    
    var pictureOfTheDayVM = PictureOfTheDayVM()
    @State var selectedDate: Date = Date()
    @State var loadingState: LoadingState = .idle
    @State var pictureOfDay = PictureOfDay()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer().frame(height: 20)
                    .navigationTitle(navigationTitleText)
                ///Date picker card
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .shadow(radius: 10)
                    VStack {
                        DatePickerView { date in
                            self.selectedDate = date
                            self.loadPictureOfDay()
                        }
                        Divider()
                        Text("\(searchingFor) \(selectedDate.formatted(date: .long, time: .omitted))")
                            .font(.subheadline)
                    }.padding()
                }.frame(height: 150)
                
                Spacer().frame(height: 10)
                ///Load image card view
                VStack {
                    switch loadingState {
                    case .idle: EmptyView()
                    case .loading: ProgressView()
                    case .loaded:
                        VStack {
                            if let msg = pictureOfDay.msg, pictureOfDay.url == nil {
                                //Display message returned in response
                                Text(msg)
                            } else {
                                //Load image card
                                ImageCardView(pictureOfDay: .constant(pictureOfDay))
                            }
                        }
                    case .failed(let serviceError):
                        Text(serviceError?.errorMessage ?? failedToLoad)
                    }
                }
            }
            .onAppear(perform: {
                loadPictureOfDay()
            })
        }
    }
    
    ///to load picture of the given day
    func loadPictureOfDay() {
        loadingState = .loading
        //search the picture in favorites list and get it from their
        let selectedDateString = selectedDate.toString(dateFormat: dateFormatterGet)
        if favorites.pictures.contains(where: { $0.date == selectedDateString}),
           let pictureOfDay = favorites.pictures.first(where: { $0.date == selectedDateString}) {
            self.pictureOfDay = pictureOfDay
            loadingState = .loaded
        } else {
            //Make API if picture is not present in the favorites list
            Task {
                await pictureOfTheDayVM.fetchAstronomyPicture(of: selectedDate,
                                                              completion: { response, error in
                    guard let response = response, error == nil else {
                        loadingState = .failed(error as? ServiceError ?? .unknownError)
                        return
                    }
                    self.pictureOfDay = response
                    loadingState = .loaded
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PictureOfTheDayView()
    }
}
