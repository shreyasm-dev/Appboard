//
//  AppIntent.swift
//  Dashboard
//
//  Created by SM on 2024.02.20.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
  static var title: LocalizedStringResource = "Configuration"
  static var description = IntentDescription("This is the Appboard widget")
  
  @Parameter(title: "Paths to Apps", default: [
    "/System/Applications/System Settings.app",
    "/System/Applications/Facetime.app",
    "/System/Applications/Messages.app",
    "/System/Applications/Photos.app"
  ])
  var paths: [String]
}
