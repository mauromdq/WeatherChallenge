//
//  Request.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 13/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation

class Request {
    
    private weak var task: URLSessionDataTask?
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
}



// ++++++++++++++
// +++++++++++++++++++++++++++++++++++++++++++++ ApiRequest +++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++
struct ApiRequest<Resource: ApiResource> {
    let resource: Resource
}

extension ApiRequest: NetworkRequest {
    typealias LoadedType = Resource.Model
    
    @discardableResult
    func load(then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request? {
            return self.load(request: resource.urlRequest, then: handler)
    }
    
    func decode(_ data: Data, for response: URLResponse?) throws -> Resource.Model {
        let model = try makeModel(with: data)
        if let response = response {
            let cachedResponse = CachedURLResponse(response: response, data: data, userInfo: ["timestamp": Date().timeIntervalSince1970], storagePolicy: .allowed)
            URLCache.shared.storeCachedResponse(cachedResponse, for: resource.urlRequest)
        }
        return model
    }
    
    private func makeModel(with data: Data)  throws -> Resource.Model {
        return try resource.makeModel(fromData: data)
    }
}



// ++++++++++++++
// +++++++++++++++++++++++++++++++++++++++++++++ NetworkRequest +++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++
protocol NetworkRequest {
    associatedtype LoadedType
    func load(then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request?
    func decode(_ data: Data, for response: URLResponse?) throws -> LoadedType
}

extension NetworkRequest {
    
    @discardableResult
    func load(request: URLRequest, then handler: @escaping (Result<LoadedType, Error>) -> Void) -> Request? {
        var urlRequest = request
//        if let accessToken = accessToken {
//            urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
//        }
        let configuration = URLSessionConfiguration.default
//#if ENV_PROD
//        configuration.connectionProxyDictionary = [:]
//        configuration.connectionProxyDictionary?[kCFNetworkProxiesHTTPEnable] = 0
//        configuration.connectionProxyDictionary?[kCFProxyTypeKey] = kCFProxyTypeNone
//#endif
        let session = URLSession.shared //URLSession(
//            configuration: configuration,
//            delegate: SessionPinningDelegate.shared,
//            delegateQueue: nil
//        )
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let httpResponse = response as? HTTPURLResponse, !(200..<300 ~= httpResponse.statusCode) {
                if httpResponse.statusCode != 401 {
//                    let url = (try? request.url?.absoluteString.replacingOccurences(ofRegex: "/\\d+/", with: "/<id>/")) ?? "com.prisma.todopago"
//                    let error = NSError(domain: url,
//                                        code: httpResponse.statusCode,
//                                        userInfo: ["url": request.url?.absoluteString ?? "", "data": data?.utf8String ?? ""])
//                    Crashlytics.crashlytics().record(error: error)
                }
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.serverError(code: httpResponse.statusCode, data: data)))
                }
                return
            }
            if error != nil {
                DispatchQueue.main.async {
                    if let noConnectionError = error?.code, noConnectionError == -1009 {
                        handler(Result.failure(NetworkError.connectionError))
                    } else {
                        handler(Result.failure(error!))
                    }
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.nilData))
                }
                return
            }
            do {
                let loadedType = try self.decode(data, for: response)
                DispatchQueue.main.async {
                    handler(Result.success(loadedType))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(Result.failure(NetworkError.decodeFail(error)))
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
        
        return Request(task: task)
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}



// ++++++++++++++
// +++++++++++++++++++++++++++++++++++++++++++++ NetworkError +++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++
enum NetworkError: Error {
    case serverError(code: Int, data: Data?)
    case nilData
    case decodeFail(Error?)
    case connectionError
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case let .serverError(code, data):
            if let data = data, let content = String(data: data, encoding: .utf8) {
                return "Error \(code) - \(content)"
            } else {
                return "Error \(code) - Se produjo un error."
            }
        case .nilData:
            return "El contenido de la respuesta está vacio."
        case .decodeFail(let underlying):
            return underlying?.localizedDescription ?? "El contenido de la respuesta tiene un formato invalido."
        case .connectionError:
            return ""
        }
    }
}

class EmptyNetworkResult { }

