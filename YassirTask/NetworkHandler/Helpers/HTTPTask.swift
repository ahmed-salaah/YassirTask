//
//  HTTPTask.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

// MARK: - Request Task
public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionalHeaders: HTTPHeaders?)
}
