//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Marcos Reboucas on 25/05/21.
//

import Foundation

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
