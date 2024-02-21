//
//  Helpers.swift
//  DashboardExtension
//
//  Created by SM on 2024.02.20.
//

import AppKit

func getIcon(file path: String) -> NSImage? {
  guard FileManager.default.fileExists(atPath: path)
  else { return nil }
  
  return NSWorkspace.shared.icon(forFile: path)
}

func appboardURL(_ path: String) -> URL {
  var url = URL(string: "appboard://open")!
  url.append(queryItems: [URLQueryItem(name: "path", value: path)]) // TODO: Handle URL encoding
  return url
}
