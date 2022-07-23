//
//  String+Extension.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 23/07/22.
//

import Foundation

extension String {
    func toDate(dateFormat format: String = dateFormatterGet) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
