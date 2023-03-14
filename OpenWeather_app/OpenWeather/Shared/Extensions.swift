//
//  Extensions.swift
//  OpenWeather
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import Foundation

// Extension of the Dictionary class to convert a dictionary into a JSON string.
extension Dictionary {

    /// Converts Dictionary to JSON string.
    /// - Throws: An exception if dictionary cannot be converted to JSON data or when data cannot be converted to UTF8 string.
    /// - Returns: JSON string.
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        // If the data cannot be converted to a UTF8 string, throws an exception.
        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
}

// Extension of the Int class to convert a UNIX timestamp into a formatted string.
extension Int {

    /// Converts a UNIX timestamp into a formatted time string.
    /// - Returns: A formatted time string.
    func toTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+01:00") //wanted timezone
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm" //wanted format
        return dateFormatter.string(from: date)
    }
    
    /// Converts a UNIX timestamp into a formatted date string.
    /// - Returns: A formatted date string.
    func toDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+01:00") //wanted timezone
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM" //wanted format
        return dateFormatter.string(from: date)
    }

}
