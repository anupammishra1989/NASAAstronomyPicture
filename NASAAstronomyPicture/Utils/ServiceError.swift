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
    
    var errorMessage: String {
        switch self {
        case .unknownError, .connectionError, .invalidRequest, .unsuppotedURL:
            return "An unknown error occurred. Please try again later"
        case .notFound:
            return "Requested data not found, please try again later"
        case .timeOut:
            return "Your request timed out. Please retry the request"
        }
    }
}
