//
//  EndPoint.swift
//  Coupons
//
//  Created by Tal talspektor on 25/01/2021.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias HTTPHeaders = [String: String]
typealias QueryParams = [String: String]
typealias Parameters = [String: Any]

enum HTTPTask {
    case request
    
    case requestParametest(bodyParameters: Parameters?, urlParanatars: QueryParams?)
    
    case requestParametersAnyHeaders(bodyParameters: Parameters?, urlParanatars: QueryParams?, additionalHeaders: HTTPHeaders?)
}
