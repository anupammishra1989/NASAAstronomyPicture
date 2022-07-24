//
//  LoadingState.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 21/07/22.
//

enum LoadingState {
    case idle
    case loading
    case loaded
    case failed(ServiceError?)
}
