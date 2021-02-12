//
//  NetworkManager.swift
//  Coupons
//
//  Created by Tal talspektor on 25/01/2021.
//

import Foundation

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case uableToDecode
    case responseError
    
    var desscription: String {
        switch self {
        case .success:
            return "success"
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad requesr."
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .uableToDecode:
            return "We could not decode the response."
        case .responseError:
            return "Response Error..."
        }
    }
}

struct NetworkResponseHandler {

    enum Result<String> {
        case success(String)
        case failure(String)
    }

    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<NetworkResponse> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponse.success)
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .success(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
    
}
