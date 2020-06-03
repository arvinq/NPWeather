//
//  ErrorMessage.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

enum NPError: String, Error {
    case invalidUrl        = "Invalid Request. Please contact the administrator."
    case invalidData       = "The data received from the server is invalid. Please try again."
    case invalidResponse   = "Invalid response from the server. Please try again."
    case unableToComplete  = "Unable to complete your request. Please check your network connection."
}
