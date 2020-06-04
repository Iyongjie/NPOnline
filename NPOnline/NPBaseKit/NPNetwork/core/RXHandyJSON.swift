//
//  RXHandyJSON.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/8.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import Moya
 
enum NPError : Swift.Error {
    // 解析失败
    case ParseJSONError
    // 网络请求发生错误
    case RequestFailed
    // 接收到的返回没有data
    case NoResponse
    //服务器返回了一个错误代码
    case UnexpectedResult(resultCode: Int?, resultMsg: String?)
}

// 服务器状态码
enum NPRequestStatus: Int {
    case requestError
    case requestSuccess
}

fileprivate let RESULT_CODE = "code"
fileprivate let RESULT_MSG = "msg"
fileprivate let RESULT_DATA = "data"

public extension Observable {
    func mapResponseToObject<T: HandyJSON>(type: T.Type) -> Observable<T> {
        return map { response in
            
            // 得到response
            guard let response = response as? Moya.Response else {
                throw NPError.NoResponse
            }
            
            // 检查状态码
            guard ((200...209) ~= response.statusCode) else {
                throw NPError.RequestFailed
            }
            
            guard let json = try? (JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String: Any])  else {
                throw NPError.NoResponse
            }
            
            // 服务器返回code
            if let code = json[RESULT_CODE] as? Int {
                if code == NPRequestStatus.requestSuccess.rawValue {
                    // get data
                    let data =  json[RESULT_DATA]
                    if let data = data as? Data {
                        
                        let jsonString = String(data: data, encoding: .utf8)
                        // 使用HandyJSON解析成对象
                        let object = JSONDeserializer<T>.deserializeFrom(json: jsonString)
                        if object != nil {
                            return object!
                        }else {
                            throw NPError.ParseJSONError
                        }
                    }else {
                        throw NPError.ParseJSONError
                    }
                } else {
                    throw NPError.UnexpectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
                }
            } else {
                throw NPError.ParseJSONError
            }
            
        }
    }
    
    func mapResponseToObjectArray<T: HandyJSON>(type: T.Type) -> Observable<[T]> {
        return map { response in
            
            // 得到response
            guard let response = response as? Moya.Response else {
                throw NPError.NoResponse
            }
            
            // 检查状态码
            guard ((200...209) ~= response.statusCode) else {
                throw NPError.RequestFailed
            }
            
            guard let json = try? (JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String: Any])  else {
                throw NPError.NoResponse
            }
            
            // 服务器返回code
            if let code = json[RESULT_CODE] as? Int {
                if code == NPRequestStatus.requestSuccess.rawValue {
                    guard let objectsArrays = json[RESULT_DATA] as? NSArray else {
                        throw NPError.ParseJSONError
                    }
                    // 使用HandyJSON解析成对象数组
                    if let objArray = JSONDeserializer<T>.deserializeModelArrayFrom(array: objectsArrays) {
                        if let objectArray: [T] = objArray as? [T] {
                            return objectArray
                        }else {
                            throw NPError.ParseJSONError
                        }
                    }else {
                        throw NPError.ParseJSONError
                    }
 
                } else {
                    throw NPError.UnexpectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
                }
            } else {
                throw NPError.ParseJSONError
            }
        }
    }
}
