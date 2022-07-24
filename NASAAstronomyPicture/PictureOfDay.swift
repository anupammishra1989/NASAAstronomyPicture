//
//  PictureOfDay.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 22/07/22.
//

import Foundation

struct PictureOfDay: Codable, Hashable {
    let date: String?
    let explanation: String?
    let hdurl: String?
    let media_type: String?
    let title: String?
    let url: String?
    let code: Int?
    let msg: String?
    
    init(date: String? = nil,
         explanation: String? = nil,
         hdurl: String? = nil,
         media_type: String? = nil,
         title: String? = nil,
         url: String? = nil,
         code: Int? = nil,
         msg: String? = nil) {
        
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.media_type = media_type
        self.title = title
        self.url = url
        self.code = code
        self.msg = msg
    }
}
