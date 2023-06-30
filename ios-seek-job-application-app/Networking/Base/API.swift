//
//  API.swift
//  ios-seek-job-application-app
//
//  Created by Mohammad Hasif Afiq on 30/06/2023.
//

import Foundation
import Combine

class API {
    static let shared = API()
    private var cancellables = Set<AnyCancellable>()

    private init() {}

    func request<T: Decodable>(endpoint: Endpoint, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else { return promise(.failure(RequestError.unknown)) }
            
            var urlComponents = URLComponents()
            urlComponents.scheme = endpoint.scheme
            urlComponents.host = endpoint.host
            urlComponents.path = endpoint.path
            
            guard let url = urlComponents.url else { return promise(.failure(RequestError.invalidURL)) }
            
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.header

            if let body = endpoint.body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let response = response as? HTTPURLResponse else { throw RequestError.noResponse }

                    #if DEBUG
                    print("⬅️⬅️⬅️⬅️⬅️ Request:")
                    print("🎯 Endpoint: \(url)")
                    
                    if let requestHeader = endpoint.header {
                        print("👤 Header: \(requestHeader)")
                    }
                    
                    if let requestBody = endpoint.body {
                        print("📦 Body: \(requestBody)")
                    }
                    
                    print("⚙️ Method: \(endpoint.method.rawValue)")
                    print("➡️➡️➡️➡️➡️ Response:")
                    print("🔢 Status code: \(response.statusCode)")
                    print("👤 Header: \(response.allHeaderFields)")
                    #endif

                    switch response.statusCode {
                    case 200...299:
                        return data
                    case 401:
                        throw RequestError.unauthorized
                    default:
                        throw RequestError.unexpectedStatusCode
                    }
                }
                .decode(type: type, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    guard self != nil else { return promise(.failure(RequestError.unknown)) }
                    
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { [weak self] value in
                    guard self != nil else { return promise(.failure(RequestError.unknown)) }
                                     
                    #if DEBUG
                    print("📦 Payload: \(value)")
                    #endif

                    promise(.success(value))
                })
                .store(in: &self.cancellables)
        }
    }
}
