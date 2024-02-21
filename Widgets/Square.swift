//
//  Square.swift
//  WidgetsExtension
//
//  Created by SM on 2024.02.21.
//

import WidgetKit
import SwiftUI
import AppIntents
import AppboardKit

struct SquareConfiguration: WidgetConfigurationIntent {
  static var title: LocalizedStringResource = "Configuration"
  static var description = IntentDescription("Square Appboard widget")
  
  @Parameter(title: "Paths to Apps", default: [
    "/System/Applications/Messages.app",
    "/System/Applications/Facetime.app",
    "/System/Applications/Photos.app",
    "/System/Applications/Mail.app"
  ])
  var paths: [String]
}

struct SquareEntryView : View {
  var entry: Provider<SquareConfiguration>.Entry
  let rows: Int
  let grid: [[String?]]
  
  init(entry: Provider<SquareConfiguration>.Entry) {
    self.entry = entry
    self.rows = Int(Float(entry.configuration.paths.count).squareRoot().rounded(.up))
    
    var grid = Array(repeating: Array(repeating: nil as String?, count: rows), count: rows)
    
    for i in 0..<rows {
      for j in 0..<rows {
        grid[i][j] = (i * rows) + j < entry.configuration.paths.count ? entry.configuration.paths[(i * rows) + j] : nil
      }
    }
    
    self.grid = grid
  }
  
  var body: some View {
    VStack {
      Grid {
        ForEach(self.grid, id: \.self) { row in
          GridRow {
            ForEach(row, id: \.self) { path in
              if let path = path {
                Link(destination: Appboard.appboardURL(path), label: {
                  Appboard.getIconImage(path)
                })
              } else {
                EmptyView()
              }
            }
          }
        }
      }
    }
  }
}

struct Square: Widget {
  let kind: String = "Quadruple"
  
  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: SquareConfiguration.self, provider: Provider()) { entry in
      SquareEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
    .supportedFamilies([.systemSmall, .systemLarge])
  }
}
