//
//  Base64EncoderDecoder.swift
//  GitHubApp
//
//  Created by Tianid on 26.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

class Base64EncoderDecoder {
    
    static func base64Encode(string: String) -> String? {
        if let data = string.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    static  func base64Decoded(string: String) -> String? {
        let newString = string.replacingOccurrences(of: "\n", with: "")
        guard let data = Data(base64Encoded: newString) else { return nil }
        return String(data: data, encoding: .utf8)
       }
}


    
