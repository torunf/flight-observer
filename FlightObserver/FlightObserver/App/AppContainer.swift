//
//  AppContainer.swift
//  FlightObserver
//
//  Created by Furkan Torun on 8.11.2021.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    
    let router = AppRouter()
    let service = LaunchApiService()
    
}
