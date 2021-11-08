//
//  LaunchDetail.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import UIKit
import Foundation

public struct LaunchDetail: Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case flight_number
        case mission_name
        case launch_date = "launch_date_unix"
        case details
        case links
    }
    
    public let flight_number: Int
    public let mission_name: String
    public let launch_date: Date
    public let details: String?
    public let links: LaunchDetailLinks
    
    public var launchDateFormatted: String {        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        return dateFormatterPrint.string(from: launch_date)
    }
    
    
}
