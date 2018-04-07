//
//  Data+String.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 9. 15..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import Foundation

protocol DataStringConvertible {
  var hexString: String { get }
}

extension Data: DataStringConvertible {}

extension DataStringConvertible {

  var hexString: String {
    guard let data = self as? Data else { return "" }
    return data.reduce("") { $0 + String.init(format: "%02x", $1) }
  }

}
