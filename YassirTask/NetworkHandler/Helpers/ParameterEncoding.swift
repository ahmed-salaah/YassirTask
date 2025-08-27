//
//  ParameterEncoding.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

import Foundation

// MARK: - Encoding
public protocol ParameterEncoding {
    func encode(urlRequest: inout URLRequest,
                bodyParameters: Parameters?,
                urlParameters: Parameters?) throws
}

public struct JSONParameterEncoder: ParameterEncoding {
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        if let bodyParameters = bodyParameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let urlParameters = urlParameters {
            var components = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
            components?.queryItems = urlParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            urlRequest.url = components?.url
        }
    }
}

