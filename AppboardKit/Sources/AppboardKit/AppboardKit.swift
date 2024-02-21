import AppKit
import SwiftUI

public struct Appboard {
  public static let imageSize = NSSize(width: 1024, height: 1024)
  public static let defaultImage = NSImage(color: .red, size: imageSize)
  
  public static func getIcon(_ path: String) -> NSImage {
    guard FileManager.default.fileExists(atPath: path)
    else { return self.defaultImage }
    
    let icon = NSWorkspace.shared.icon(forFile: path)
    icon.size = self.imageSize
    return icon
  }
  
  public static func getIconImage(_ path: String) -> some View {
    Image(nsImage: self.getIcon(path))
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
  
  public static func appboardURL(_ path: String) -> URL {
    var url = URL(string: "appboard://open")!
    url.append(queryItems: [URLQueryItem(name: "path", value: path)]) // TODO: Handle URL encoding
    return url
  }
}

public extension NSImage {
  convenience init(color: NSColor, size: NSSize) {
    self.init(size: size)
    lockFocus()
    color.drawSwatch(in: NSRect(origin: .zero, size: size))
    unlockFocus()
  }
}

public extension Int {
  func cgFloat() -> CGFloat {
    CGFloat(integerLiteral: self)
  }
}
