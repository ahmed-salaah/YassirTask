//
//  EndPointType.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//
import Foundation
// MARK: - Endpoint Protocol
public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
