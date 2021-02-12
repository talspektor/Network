//
//  NetworkError.swift
//  Coupons
//
//  Created by Tal talspektor on 25/01/2021.
//

import Foundation

enum NetworkError: String, Error {
    case parametersNil = "Parameters are nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case mustByEncodable = "mustByEncodable"
    case nissingData = "nissingData"
}
