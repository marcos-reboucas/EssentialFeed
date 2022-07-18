//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Marcos Reboucas on 18/07/22.
//

import Foundation

extension HTTPURLResponse {
    
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
