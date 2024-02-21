// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppboardKit",
  platforms: [.macOS(.v13)],
  products: [
    .library(
      name: "AppboardKit",
      targets: ["AppboardKit"]),
  ],
  targets: [
    .target(
      name: "AppboardKit"),
  ]
)
