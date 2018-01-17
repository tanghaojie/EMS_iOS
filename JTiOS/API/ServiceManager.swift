//
//  MoyaManager.swift
//  JTiOS
//
//  Created by JT on 2017/12/21.
//  Copyright © 2017年 JT. All rights reserved.
//
import Alamofire
import Moya

class ServiceManager {
    static let shareInstance = ServiceManager()
    private init() {}

    let provider = MoyaProvider<Service>(manager: DefaultAlamofireManager.sharedManager)
    let provider_2s = MoyaProvider<Service>(manager: DefaultAlamofireManager_2.sharedManager)
    
    func sync_Json_Post(url: String, data: Foundation.Data? = nil) -> (data: Foundation.Data?, response: URLResponse?, error: Error?) {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.timeoutInterval = TimeInterval(5)
        urlRequest.httpMethod = HttpMethod.POST.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        urlRequest.httpShouldHandleCookies = true
        var response: URLResponse?
        var rData: Foundation.Data?
        var rError: Error?
        do {
            rData = try NSURLConnection.sendSynchronousRequest(urlRequest, returning: &response)
        } catch {
            rError = error
        }
        return (rData,response,rError)
    }
    
    //    func async_Json_Post(url: String, data: Foundation.Data? = nil, completionHandler: @escaping (Foundation.Data?, URLResponse?, Error?) -> Void) {
    //        var urlRequest = URLRequest(url: URL(string: url)!)
    //        urlRequest.timeoutInterval = TimeInterval(5)
    //        urlRequest.httpMethod = HttpMethod.POST.rawValue
    //        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    //        urlRequest.httpBody = data
    //        urlRequest.httpShouldHandleCookies = true
    //        let session = URLSession.shared
    //        session.dataTask(with: urlRequest) { (data,response,error) in
    //            completionHandler(data, response, error)
    //        }.resume()
    //    }
    
    private class DefaultAlamofireManager: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 5
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
    private class DefaultAlamofireManager_2: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 2
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
}
