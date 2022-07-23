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
                            self.loadData()
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
                            ImageCardView(pictureOfDay: .constant(pictureOfDay))
                        }
                    case .failed:
                        Text(failedToLoad)
                    }
                }
            }
            .onAppear(perform: {
                loadData()
            })
        }
    }
    
    ///to load picture of the given day
    func loadData() {
        Task {
            loadingState = .loading
            await pictureOfTheDayVM.fetchAstronomyPicture(of: selectedDate,
                                                          completion: { response, error in
                guard let response = response, error == nil else {
                    loadingState = .failed
                    return
                }
                pictureOfDay = response
                loadingState = .loaded
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PictureOfTheDayView()
    }
}
