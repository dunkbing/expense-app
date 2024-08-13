//
//  Color.swift
//  Expense
//
//  Created by Bing on 13/8/24.
//

import Foundation
import SwiftUI

func colorFromString(_ colorName: String) -> Color {
    switch colorName.lowercased() {
    case "red":
        return Color.red
    case "blue":
        return Color.blue
    case "brown":
        return Color.brown
    case "purple":
        return Color.purple
    case "green":
        return Color.green
    case "yellow":
        return Color.yellow
    case "pink":
        return Color.pink
    case "orange":
        return Color.orange
    case "white":
        return Color.white
    case "cyan":
        return Color.cyan
    case "magenta":
        return Color(red: 1.0, green: 0.0, blue: 1.0)
    case "navy":
        return Color(red: 0.0, green: 0.0, blue: 0.5)  // Custom color
    case "gold":
        return Color(red: 1.0, green: 0.84, blue: 0.0)  // Custom color
    case "teal":
        return Color.teal
    case "turquoise":
        return Color(red: 0.25, green: 0.88, blue: 0.82)  // Custom color
    case "lime":
        return Color(red: 0.75, green: 1.0, blue: 0.0)  // Custom color
    case "silver":
        return Color(red: 0.75, green: 0.75, blue: 0.75)  // Custom color
    case "maroon":
        return Color(red: 0.5, green: 0.0, blue: 0.0)  // Custom color
    case "lavender":
        return Color(red: 0.9, green: 0.9, blue: 0.98)  // Custom color
    case "olive":
        return Color(red: 0.5, green: 0.5, blue: 0.0)  // Custom color
    default:
        return Color.gray  // Default color if not matched
    }
}
