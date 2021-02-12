//
//  JSONEncoder+Extension.swift
//  Coupons
//
//  Created by Tal talspektor on 03/02/2021.
//

import Foundation

extension JSONEncoder {
    func encode<T: Encodable>(from data: T) throws -> Data {
        do {
            return try encode(data)
        } catch {
            throw error
        }
    }
}
