//
//  JSONDecoder+Extension.swift
//  Coupons
//
//  Created by Tal talspektor on 03/02/2021.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(with type: T.Type, from data: Data) throws -> T {
        do {
            return try decode(T.self, from: data)
        } catch {
            print(error)
            throw NetworkResponse.uableToDecode
        }
        
    }
}
