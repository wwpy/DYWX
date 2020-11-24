//
//  WYDecoder.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

enum WYError: Error {
    case message(String)
}

struct WYDecoder {
    
    static func decode<T>(_ type: T.Type, data: Data) throws -> T where T: Decodable {
        guard let model = try? JSONDecoder().decode(type, from: data) else {
            throw WYError.message("转换模型失败")
        }
        
        return model
    }
    
    static func decode<T>(_ type: T.Type, param: [String : String]) throws -> T where T: Decodable {
        guard let jsonData = self.getJsonData(with: param) else {
            throw WYError.message("转换 data 失败")
        }
        
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            throw WYError.message("转换模型失败")
        }
        return model
    }
    
    static func getJsonData(with param: Any) -> Data? {
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) else {
            return nil
        }
        
        return data
    }
}
