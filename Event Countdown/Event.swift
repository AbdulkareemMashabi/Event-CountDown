//
//  Event.swift
//  Event Countdown
//
//  Created by Abdulkareem Mashabi on 25/01/1447 AH.
//

import Foundation
import SwiftUICore

import SwiftUI
import UIKit // Needed for UIColor

extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self = Color(hex: hex)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.toHex() ?? "#000000") // fallback to black
    }

    // Convert Color -> Hex string (via UIColor)
    func toHex() -> String? {
        #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        , a: CGFloat = 0
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        #else
        return nil
        #endif
    }

    // Convert Hex string -> Color
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // skip the leading #
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

struct Event: Comparable, Identifiable, Codable, Hashable {
    var id = UUID();
    var title: String;
    var date: Date;
    var textColor: Color
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}
