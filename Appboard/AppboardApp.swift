//
//  AppboardApp.swift
//  Appboard
//
//  Created by SM on 2024.02.20.
//

import SwiftUI

var terminate = false

@main
struct AppboardApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .windowStyle(.hiddenTitleBar)
    .windowResizability(.contentSize)
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    if terminate {
      NSApp.terminate(nil)
    }
  }
  
  // TODO: Something better
  func applicationDidUpdate(_ notification: Notification) {
    if let window = NSApp.mainWindow {
      if !window.isMovableByWindowBackground {
        window.isMovableByWindowBackground = true
      }
    }
  }
}
