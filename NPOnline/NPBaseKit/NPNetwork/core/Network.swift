//
//  Network.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/8.
//  Copyright © 2020 NewPath. All rights reserved.
//
 
import Moya

public class Network {
    
    public static let `default`: Network = {
        Network(configuration: Configuration.default)
    }()
    
    public let provider: MoyaProvider<MultiTarget>
    
    public init(configuration: Configuration) {
        provider = MoyaProvider(configuration: configuration)
    }
}

public extension MoyaProvider {
    
    convenience init(configuration: Network.Configuration) {
        
        let endpointClosure = { target -> Endpoint in
            MoyaProvider.defaultEndpointMapping(for: target)
                .adding(newHTTPHeaderFields: configuration.addingHeaders(target))
                .replacing(task: configuration.replacingTask(target))
        }
        
        let requestClosure =  { (endpoint: Endpoint, closure: RequestResultClosure) -> Void in
            do {
                
                var request = try endpoint.urlRequest()
                  
                // 打印请求参数
                if request.httpBody != nil {
                    print("请求" + "\(request.httpMethod ?? "")" + "\n" + "\(request.url!)" + "?" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
                }else{
                    print("请求" + "\(request.httpMethod ?? "")" + "\n" + "\(request.url!)")
                }
                 
                request.timeoutInterval = configuration.timeoutInterval
                closure(.success(request))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(.parameterEncoding(error)))
            } catch {
                closure(.failure(.underlying(error, nil)))
            }
        }
        
        self.init(endpointClosure: endpointClosure,
                  requestClosure: requestClosure,
                  plugins: configuration.plugins)
    }
}
