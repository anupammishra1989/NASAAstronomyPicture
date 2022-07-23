//
//  DateExtension.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

import Foundation

extension Date {
    func toString(dateFormat format: String = dateFormatterPrint) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
