//
//  AppboardApp.swift
//  Appboard
//
//  Created by SM on 2024.02.20.
//

import SwiftUI

@main
struct AppboardApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      EmptyView()
        .onOpenURL {
          guard $0.scheme == "appboard" else {
            NSApp.terminate(nil)
            exit(1)
          }
          
          guard let components = URLComponents(url: $0, resolvingAgainstBaseURL: true) else {
            NSApp.terminate(nil)
            exit(1)
          }
          
          guard let action = components.host, action == "open" else {
            NSApp.terminate(nil)
            exit(1)
          }
          
          guard let path = components.queryItems?.first(where: { $0.name == "path" })?.value else {
            NSApp.terminate(nil)
            exit(1)
          }
          
          NSWorkspace.shared.open(URL(filePath: path))
        }
    }
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    NSApp.terminate(nil)
  }
}
