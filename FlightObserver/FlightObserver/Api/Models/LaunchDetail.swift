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
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDate = "launch_date_unix"
        case details
        case links
    }
    
    public let flightNumber: Int
    public let missionName: String
    public let launchDate: Date
    public let details: String?
    public let links: LaunchDetailLinks
    
    public var launchDateFormatted: String {        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        return dateFormatterPrint.string(from: launchDate)
    }
    
    
}
