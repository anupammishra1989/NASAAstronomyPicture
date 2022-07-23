//
//  PictureOfTheDayVM.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

import Foundation

struct PictureOfTheDayVM {
    
    /// get service call
    func fetchAstronomyPicture(of date: Date,
                               completion: @escaping (_ response: PictureOfDay?,
                                                      _ error: Error?) -> Void) async {
        await NetworkOperation.fetchAstronomyPicture(of: date.toString()) { response, error in
            guard let response = response,
                    error == nil else {
                        completion(nil, error)
                        return
            }
            completion(mapPictureOfDay(response: response), error)
        }
    }
    
    ///map response to PictureOfDay object
    private func mapPictureOfDay(response: PictureOfDateModel) -> PictureOfDay {
        return PictureOfDay(date: response.date,
                            explanation: response.explanation,
                            hdurl: response.hdurl,
                            media_type: response.media_type,
                            title: response.title,
                            url: response.url)
    }
}
