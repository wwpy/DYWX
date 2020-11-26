//
//  WYString+Extension.swift
//  DYWX
//
//  Created by 王武 on 2020/11/26.
//

import Foundation
import CommonCrypto

extension String {
    var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    /// 是否包含字符串
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    /// sha256加密
    func sha256() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(str!, strLen, result)
        let hash = NSMutableString()
        for num in 0 ..< digestLen {
            hash.appendFormat("%02x", result[num])
        }
        result.deinitialize(count: 1)
        
        return String(format: hash as String)
    }
    
    /// 截取任意位置到结束
    func stringCutToEnd(start: Int) -> String {
        if !(start < count) {
            return "截取超出范围"
        }
        let sRang = index(startIndex, offsetBy: start)..<endIndex
        
        return String(self[sRang])
    }
    
    /// 截取任意位置
    func stringCutTo(start: Int, end: Int) -> String {
        guard start < end else {
            return "起始位置不能大于终点位置"
        }
        guard end < count else {
            return "截取超出范围"
        }
        let sRang = index(startIndex, offsetBy: start)..<index(startIndex, offsetBy: end)
        
        return String(self[sRang])
    }
}
