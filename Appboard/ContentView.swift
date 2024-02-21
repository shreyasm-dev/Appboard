//
//  ContentView.swift
//  Appboard
//
//  Created by SM on 2024.02.21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      VStack {
        Image(nsImage: { () -> NSImage in
          let image = NSImage(named: "AppIcon")!
          image.size = NSSize(width: 128, height: 128)
          return image
        }())
        
        Text("Appboard")
          .font(.largeTitle)
          .bold()
      }
      
      Spacer()
      
      VStack(spacing: 20) {
        Text("Appboard has no user interface. It installs widgets that you can use on the Desktop or in the Notification Center.")
        
        Text("Appboard *must* be run from the Applications folder. It will not work otherwise.")
          .bold()
        
        Text(.init("See [Apple Support](https://support.apple.com/guide/mac-help/add-and-customize-widgets-mchl52be5da5/mac) for more information."))
      }
      .lineSpacing(3.0)
      
      Spacer()
      
      Button {
        NSApp.terminate(nil)
      } label: {
        Text("Quit")
      }
      .controlSize(.large)
      
      Spacer()
    }
    .padding(30)
    .ignoresSafeArea()
    .multilineTextAlignment(.center)
    .frame(width: 350, height: 500)
    .onOpenURL {
      terminate = true
      
      guard $0.scheme == "appboard" else {
        return
      }
      
      guard let components = URLComponents(url: $0, resolvingAgainstBaseURL: true) else {
        return
      }
      
      guard let action = components.host, action == "open" else {
        return
      }
      
      guard let path = components.queryItems?.first(where: { $0.name == "path" })?.value else {
        return
      }
      
      NSWorkspace.shared.open(URL(filePath: path))
    }
  }
}
