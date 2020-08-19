//
//  ServiceManager.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation

import Alamofire

public enum ServiceError: Error {
    case serviceFailure(reason: String)
    case connectivityError
    case unknownError
}

class ServicesManager {
    
    private static let alamoFireManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        var timeout: TimeInterval = 60
        
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    public static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? true
    }
    
    static func sendRequest<T: Decodable>(urlString: String,
                                          parameters: [String: Any]?,
                                          method: HTTPMethod,
                                          encoding: ParameterEncoding = URLEncoding.queryString,
                                          completion: @escaping (Result<T>) -> Void) -> Request? {
        
        let request = alamoFireManager.request(urlString, method: method, parameters: parameters, encoding: encoding)
        NSLog("Sending request to \(request.request?.url?.absoluteString ?? "")")
        
        request.validate()
        
        if !ServicesManager.isConnectedToInternet() {
            completion(.failure(ServiceError.connectivityError))
            return request
        }
        
        request.responseJSON { response in
            if let code = response.response?.statusCode {
                NSLog("  Received response: \(code) \(HTTPURLResponse.localizedString(forStatusCode: code))")
            }
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                do {
                    if let data = response.data {
                        let decodedResponse: T = try decoder.decode(T.self, from: data)
                        completion(.success(decodedResponse))
                    }
                    else {
                        let error = ServiceError.serviceFailure(reason: "Missing response data")
                        NSLog("Error: \(error)")
                        completion(.failure(error))
                    }
                }
                catch let error {
                    NSLog("Error: \(error)")
                    self.logRawResponseData(response.data)
                    completion(.failure(error))
                }
            case .failure(let error):
                debugPrint(request)
                self.logRawResponseData(response.data)
                NSLog("Error: \(error)")
                completion(.failure(error))
            }
        }
        return request
    }
    
    private static func logRawResponseData(_ data: Data?) {
        if let data = data, let utf8Text = String(data: data, encoding: .utf8) {
            // Use print, as we don't want additional output of NSLog or debugPrint
            print("********** Response Data **********")
            print(utf8Text) // original JSON data as UTF8 string
        }
    }
}
