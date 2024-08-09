//
//  SettingsView.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import SwiftUI

struct SettingsView: View {
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .green
        UITableView.appearance().backgroundColor = .green
    }
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("DATA")) {
                    NavigationLink(destination: Text("Categories View")) {
                        SettingsRow(iconName: "square.grid.2x2.fill", title: "Categories")
                    }
                    HStack {
                        SettingsRow(iconName: "icloud.fill", title: "iCloud Sync")
                        Spacer()
                        Toggle("", isOn: .constant(true))
                            .labelsHidden()
                    }
                    NavigationLink(destination: Text("Import Data View")) {
                        SettingsRow(iconName: "arrow.down.doc.fill", title: "Import Data")
                    }
                    NavigationLink(destination: Text("Export Data View")) {
                        SettingsRow(iconName: "arrow.up.doc.fill", title: "Export Data")
                    }
                    NavigationLink(destination: Text("Erase Data View")) {
                        SettingsRow(iconName: "trash.fill", title: "Erase Data")
                    }
                }
                .listRowBackground(Color.black)

                Section(header: Text("OTHERS")) {
                    HStack {
                        SettingsRow(iconName: "chart.pie.fill", title: "Animated Charts")
                        Spacer()
                        Toggle("", isOn: .constant(true))
                            .labelsHidden()
                    }
                    HStack {
                        SettingsRow(iconName: "hand.tap.fill", title: "Haptics")
                        Spacer()
                        Text("Subtle")
                            .foregroundColor(.gray)
                    }
                    NavigationLink(destination: Text("Feature Lab View")) {
                        SettingsRow(iconName: "flame.fill", title: "Feature Lab")
                    }
                    NavigationLink(destination: Text("Tip Jar View")) {
                        SettingsRow(iconName: "heart.fill", title: "Tip Jar")
                    }
                    NavigationLink(destination: Text("Report Bug View")) {
                        SettingsRow(iconName: "ladybug.fill", title: "Report Bug")
                    }
                    NavigationLink(destination: Text("Feature Request View")) {
                        SettingsRow(iconName: "star.fill", title: "Feature Request")
                    }
                    NavigationLink(destination: Text("Rate on App Store View")) {
                        SettingsRow(iconName: "star.circle.fill", title: "Rate on App Store")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsRow: View {
    var iconName: String
    var title: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
            Text(title)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SettingsView()
}
