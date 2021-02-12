//
//  Router.swift
//  Coupons
//
//  Created by Tal talspektor on 25/01/2021.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                print("========================")
                if let httpResponse = response as? HTTPURLResponse {
                    print(">>>>> HTTP STATUS: \(httpResponse.statusCode)")

                }
                print(">>>>> URL: \(String(describing: response?.url))")
                print(">>>>> Data: \(String(describing: data))")
                print(">>>>> REQUEST BODY \(String(describing: request.httpBody))")
                print(">>>>> REQUEST Method \(String(describing: request.httpMethod))")
                print(">>>>> REQUEST HEADERS \(String(describing: request.allHTTPHeaderFields))")
                print(">>>>> Error: \(String(describing: error))")
                print("========================")
                completion(NetworkResponseItem(data: data, response: response, error: error))
            })
        } catch {
            print(">>>>> Error: \(String(describing: error))")
            completion(NetworkResponseItem(data: nil, response: nil, error: error))
        }
        self.task?.resume()
    }
    
    func cansel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParametest(let bodyParameters, let urlParameters):

                try self.configurePrameters(bodyParameters: bodyParameters,
                                            urlParameters: urlParameters,
                                            request: &request)
            case .requestParametersAnyHeaders(let bodyParameters, let urlParameters, let additionalHeaders):

                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configurePrameters(bodyParameters: bodyParameters,
                                            urlParameters: urlParameters,
                                            request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    private func configurePrameters(bodyParameters: Parameters?, urlParameters: QueryParams?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encoder(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encoder(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
