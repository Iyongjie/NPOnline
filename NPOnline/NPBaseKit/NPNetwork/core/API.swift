//
//  NPAPI.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/8.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import UIKit
import Moya

public enum API {
    
    case getRequestNoParamerApi(String)
    
    case getRequestListNoParamerApi(String)
    
    case getRequestParamerDicApi(Dictionary<String, Any>,String)
    
    case getRequestListParamerDicApi(Dictionary<String, Any>,String)
    
    case postRequestNoParamerApi(String)
    
    case postRequestListNoParamerApi(String)
    
    case postRequestParamerDicApi(Dictionary<String, Any>,String)
    
    case postRequestListParamerDicApi(Dictionary<String, Any>,String)
    
    case uploadRequestParamerDicApi(Dictionary<String,Any>, [String: UIImage], String)
    
}
 
extension API: Moya.TargetType {
    public var sampleData: Data {
        return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var method: Moya.Method  {
        
        switch self {
        case .getRequestNoParamerApi(_),.getRequestListNoParamerApi(_),.getRequestParamerDicApi(_, _),.getRequestListParamerDicApi(_, _):
            
            return .get
            
        case .postRequestNoParamerApi(_),.postRequestListNoParamerApi(_),.postRequestParamerDicApi(_, _),.postRequestListParamerDicApi(_, _), .uploadRequestParamerDicApi(_, _, _):
            
            return .post
        }
    }
    
    public var validate: Bool {
        return false
    }
    
    public var parameters: [String: Any]? {
        
        switch self {
        case .getRequestNoParamerApi(_),.getRequestListNoParamerApi(_),.postRequestNoParamerApi(_),.postRequestListNoParamerApi(_):
            return nil
        case .getRequestParamerDicApi(let parm, _),.getRequestListParamerDicApi(let parm, _),.postRequestParamerDicApi(let parm, _),.postRequestListParamerDicApi(let parm, _), .uploadRequestParamerDicApi(let parm, _, _):
            return parm
        }
        
    }
    
    public var task: Task {
        switch self {
        case .uploadRequestParamerDicApi(let parameters, let images, _ ):
            let formDataAry:NSMutableArray = NSMutableArray()
            for (index,dic) in images.enumerated() {
                let image = dic.value
                let data:Data = image.jpegData(compressionQuality: 0.4)!
                let date:Date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
                var dateStr:String = formatter.string(from: date as Date)
                dateStr = dateStr.appendingFormat("-%i.jpg", index)
                let formData = MultipartFormData(provider: .data(data), name: "imageFiles", fileName: dateStr, mimeType: "image/jpeg")
                formDataAry.add(formData)
            }
            return .uploadCompositeMultipart(formDataAry as! [MultipartFormData], urlParameters: parameters )
        default:
            return Task.requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    public var parameterEncoding :ParameterEncoding {return URLEncoding.default}
    
    public var baseURL: URL {return URL(string: "https://api.xintujing.cn")!}
    
    public var path: String {
        switch self {
            
        case .getRequestNoParamerApi(let requestPath),.getRequestListNoParamerApi(let requestPath),.getRequestParamerDicApi(_, let requestPath),.getRequestListParamerDicApi(_, let requestPath),.postRequestNoParamerApi(let requestPath),.postRequestListNoParamerApi(let requestPath),.postRequestParamerDicApi(_, let requestPath),.postRequestListParamerDicApi(_, let requestPath),.uploadRequestParamerDicApi(_, _, let requestPath):
            return requestPath
        }
    }
}
