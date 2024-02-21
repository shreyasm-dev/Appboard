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

struct DashboardConfiguration: WidgetConfigurationIntent {
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

struct DashboardEntryView : View {
  var entry: Provider<DashboardConfiguration>.Entry
  let rows: Int
  let columns: Int
  let grid: [[String?]]
  
  init(entry: Provider<DashboardConfiguration>.Entry) {
    self.entry = entry
    
    switch entry.context.family {
    case .systemSmall, .systemLarge:
      self.rows = Int(Float(entry.configuration.paths.count).squareRoot().rounded(.up))
      self.columns = self.rows
    case .systemMedium, .systemExtraLarge:
      self.rows = Int(Float(entry.configuration.paths.count).squareRoot().rounded(.up)) / 2
      self.columns = self.rows * 4
    default:
      fatalError("Unreachable")
    }
    
    var grid = Array(repeating: Array(repeating: nil as String?, count: self.columns), count: self.rows)
    
    for i in 0..<self.rows {
      for j in 0..<self.columns {
        grid[i][j] = (i * self.columns) + j < entry.configuration.paths.count ? entry.configuration.paths[(i * self.columns) + j] : nil
      }
    }
    
    self.grid = grid
  }
  
  var body: some View {
    VStack {
      // For some reason, Grid doesn't work for lots of items
      ForEach(self.grid, id: \.self) { row in
        HStack {
          ForEach(row, id: \.self) { path in
            if let path = path {
              Link(destination: Appboard.appboardURL(path)) {
                Appboard.getIconImage(path)
              }
            } else {
              Appboard.getImage(Appboard.defaultImage)
                .opacity(0)
            }
          }
        }
      }
    }
  }
}

struct Dashboard: Widget {
  let kind: String = "Quadruple"
  
  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: DashboardConfiguration.self, provider: Provider()) { entry in
      DashboardEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
  }
}
