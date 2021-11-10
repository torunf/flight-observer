//
//  LaunchDetailLinks.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import UIKit
import Foundation

public struct LaunchDetailLinks: Codable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case mission_patch
        case mission_patch_small
    }
    
    public let mission_patch: String?
    public let mission_patch_small: String?
    
}
