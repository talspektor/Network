//
//  ParameterEncoder.swift
//  Coupons
//
//  Created by Tal talspektor on 25/01/2021.
//

import Foundation

protocol ParameterEncoder {
    static func encoder(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
