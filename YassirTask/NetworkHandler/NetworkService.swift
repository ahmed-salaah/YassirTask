//
//  NetworkService.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

import Foundation

// MARK: - Typealiases
public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

// MARK: - Network Service Protocol
public protocol NetworkServiceProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request<Model: Decodable>(_ route: EndPoint) async throws -> Model
}

// MARK: - Network Service
public final class NetworkService<EndPoint: EndPointType>: NetworkServiceProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Model: Decodable>(_ route: EndPoint) async throws -> Model {
        let request = try buildRequest(from: route)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

// MARK: - Private Helpers
private extension NetworkService {
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        request.httpMethod = route.httpMethod.rawValue
        
        // Global headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Endpoint headers
        if let headers = route.headers {
            headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        switch route.task {
        case .request:
            break
        case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding, let urlParameters, let additionalHeaders):
            if let headers = additionalHeaders {
                headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
            }
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        }
        
        return request
    }
}
