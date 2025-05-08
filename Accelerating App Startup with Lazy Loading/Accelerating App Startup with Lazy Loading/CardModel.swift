//
//  CardModel.swift
//  Accelerating App Startup with Lazy Loading
//
//  Created by Stephano Portella on 03/05/25.
//
import Foundation

struct Project {
    let title: String
    let lastModified: Date
    let previewImageName: String
    let description: String
}

extension Date {
    var friendlyString: String {
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        return fmt.string(from: self)
    }
}
