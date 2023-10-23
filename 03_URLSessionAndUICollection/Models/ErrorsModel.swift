//
//  ErrorsModel.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import Foundation

enum Errors: Error {
    case invalidURL
    case resourceNotFound
    case validationFailed
    case invalidResponse
    case invalidData
}

enum ImageError: Error {
    case invalidImageData
}
