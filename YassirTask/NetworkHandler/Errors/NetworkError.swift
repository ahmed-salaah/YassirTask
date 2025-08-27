//
//  NetworkError.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

// MARK: - Network Errors
public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(Int)
    case unknown(Error)
}
