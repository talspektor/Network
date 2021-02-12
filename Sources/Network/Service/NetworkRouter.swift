//
//  NetworkRouter.swift
//  Coupons
//
//  Created by Tal talspektor on 25/01/2021.
//

import Foundation
struct NetworkResponseItem {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}
typealias NetworkRouterCompletion = (_ responseItem: NetworkResponseItem) -> Void
protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cansel()
}
