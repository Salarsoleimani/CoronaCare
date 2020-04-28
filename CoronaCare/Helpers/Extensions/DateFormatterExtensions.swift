//
//  DateFormatterExtensions.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

extension Formatter {
  static let iso8601: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
  }()
  static let iso8601noFS = ISO8601DateFormatter()
}
extension JSONEncoder.DateEncodingStrategy {
  static let customISO8601 = custom {
    var container = $1.singleValueContainer()
    try container.encode(Formatter.iso8601.string(from: $0))
  }
}
extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601.date(from: string) ?? Formatter.iso8601noFS.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
