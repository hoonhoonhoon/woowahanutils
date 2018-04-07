//
//  URLComponents.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 7. 11..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import Foundation

protocol URLQueryItemParserable {

  var queries: [String: String] { get }

}

protocol URLComponentable {

  var queryItems: [URLQueryItem]? { get set }

}

extension URLQueryItemParserable where Self: URLComponentable {

  var queries: [String: String] {
    if let queryItems: [URLQueryItem] = self.queryItems {
      return queryItems.reduce([String: String]()) { (prev, item) -> [String: String] in
        var items: [String: String] = prev
        if let value = item.value {
          items[item.name] = value
        }
        return items
      }
    }
    return [:]
  }

}

extension URLComponents: URLComponentable, URLQueryItemParserable {}

extension URL: URLComponentable, URLQueryItemParserable {

  var queryItems: [URLQueryItem]? {
    get {
      return URLComponents(url: self, resolvingAgainstBaseURL: true)?.queryItems
    }
    set {}
  }

}
