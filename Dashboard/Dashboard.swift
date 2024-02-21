//
//  Dashboard.swift
//  Dashboard
//
//  Created by SM on 2024.02.20.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
  func placeholder(in context: Context) -> Entry {
    Entry(date: Date(), configuration: ConfigurationAppIntent())
  }
  
  func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> Entry {
    Entry(date: Date(), configuration: configuration)
  }
  
  func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<Entry> {
    var entries: [Entry] = []
    
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = Entry(date: entryDate, configuration: configuration)
      entries.append(entry)
    }
    
    return Timeline(entries: entries, policy: .atEnd)
  }
}

struct Entry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationAppIntent
}

struct DashboardEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      ForEach(entry.configuration.paths, id: \.self) { path in
        Link(destination: appboardURL(path)) {
          Image(nsImage: {
            let icon = getIcon(file: path)!
            icon.size = NSSize(width: 512, height: 512)
            return icon
          }())
          .resizable()
          .aspectRatio(contentMode: .fit)
        }
        .buttonStyle(.plain)
      }
    }
  }
}

struct Dashboard: Widget {
  let kind: String = "Dashboard"
  
  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
      DashboardEntryView(entry: entry)
        .containerBackground(.fill.tertiary, for: .widget)
    }
  }
}
