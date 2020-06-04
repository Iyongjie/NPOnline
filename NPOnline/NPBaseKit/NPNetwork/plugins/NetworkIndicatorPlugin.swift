//
//  NetworkIndicatorPlugin.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/8.
//  Copyright © 2020 NewPath. All rights reserved.
//
 
import Moya
import Result

public final class NetworkIndicatorPlugin: PluginType {
    
    private static var numberOfRequests: Int = 0 {
        didSet {
            if numberOfRequests > 1 { return }
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.numberOfRequests > 0
            }
        }
    }
    
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
        NetworkIndicatorPlugin.numberOfRequests += 1
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        NetworkIndicatorPlugin.numberOfRequests -= 1
    }
}
