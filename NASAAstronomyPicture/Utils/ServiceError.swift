//
//  ServiceError.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

enum ServiceError: Error {
    case unknownError
    case connectionError
    case invalidRequest
    case notFound
    case timeOut
    case unsuppotedURL
}
