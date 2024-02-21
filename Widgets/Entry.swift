//
//  Entry.swift
//  WidgetsExtension
//
//  Created by SM on 2024.02.20.
//

import WidgetKit
import AppIntents

struct Provider<T>: AppIntentTimelineProvider where T: WidgetConfigurationIntent {
  func placeholder(in context: Context) -> Entry<T> {
    Entry(date: Date(), configuration: T(), context: context)
  }
  
  func snapshot(for configuration: T, in context: Context) async -> Entry<T> {
    Entry(date: Date(), configuration: configuration, context: context)
  }
  
  func timeline(for configuration: T, in context: Context) async -> Timeline<Entry<T>> {
    var entries: [Entry] = []
    
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = Entry(date: entryDate, configuration: configuration, context: context)
      entries.append(entry)
    }
    
    return Timeline(entries: entries, policy: .atEnd)
  }
}

struct Entry<T>: TimelineEntry where T: WidgetConfigurationIntent {
  let date: Date
  let configuration: T
  let context: TimelineProviderContext
}
