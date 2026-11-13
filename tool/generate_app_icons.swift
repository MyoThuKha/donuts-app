// Run from the repository root: swift tool/generate_app_icons.swift
// Packages the supplied artwork; requires macOS AppKit, no external dependencies.
import AppKit

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let sourceURL = root.appendingPathComponent("assets/app_icon/donut-source.png")
let source = NSImage(contentsOf: sourceURL)!
let cgSource = source.cgImage(forProposedRect: nil, context: nil, hints: nil)!
let grayContext = CGContext(data: nil, width: cgSource.width, height: cgSource.height, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
grayContext.draw(cgSource, in: CGRect(x: 0, y: 0, width: cgSource.width, height: cgSource.height))
let gray = grayContext.makeImage()!

func render(_ size: Int, fraction: Double, background: String?, monochrome: Bool = false, tinted: Bool = false) -> NSBitmapImageRep {
    let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: size, pixelsHigh: size, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    let context = NSGraphicsContext(bitmapImageRep: bitmap)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    let cg = context.cgContext
    if let hex = background {
        let value = UInt32(hex, radix: 16)!
        cg.setFillColor(NSColor(srgbRed: CGFloat((value >> 16) & 255) / 255, green: CGFloat((value >> 8) & 255) / 255, blue: CGFloat(value & 255) / 255, alpha: 1).cgColor)
        cg.fill(CGRect(x: 0, y: 0, width: size, height: size))
    }
    let width = Double(size) * fraction
    let height = width * Double(cgSource.height) / Double(cgSource.width)
    let rect = CGRect(x: (Double(size) - width) / 2, y: (Double(size) - height) / 2, width: width, height: height)
    cg.interpolationQuality = .high
    if monochrome {
        // A clean ring avoids tiny cutout artifacts becoming visible in system tints.
        cg.setFillColor(NSColor.white.cgColor)
        cg.addEllipse(in: rect)
        cg.addEllipse(in: rect.insetBy(dx: rect.width * 0.32, dy: rect.height * 0.32))
        cg.drawPath(using: .eoFill)
    } else {
        cg.draw(tinted ? gray : cgSource, in: rect)
    }
    NSGraphicsContext.restoreGraphicsState()
    if background != nil {
        let opaque = CGContext(data: nil, width: size, height: size, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
        opaque.draw(bitmap.cgImage!, in: CGRect(x: 0, y: 0, width: size, height: size))
        return NSBitmapImageRep(cgImage: opaque.makeImage()!)
    }
    return bitmap
}

func save(_ bitmap: NSBitmapImageRep, _ path: String) throws {
    let url = root.appendingPathComponent(path)
    try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    try bitmap.representation(using: .png, properties: [:])!.write(to: url)
}

let catalog = "ios/Runner/Assets.xcassets/AppIcon.appiconset/"
let catalogURL = root.appendingPathComponent(catalog + "Contents.json")
var contents = try JSONSerialization.jsonObject(with: Data(contentsOf: catalogURL)) as! [String: Any]
var images = (contents["images"] as! [[String: Any]]).filter { $0["appearances"] == nil }
for entry in images {
    let points = Double((entry["size"] as! String).components(separatedBy: "x")[0])!
    let scale = Double((entry["scale"] as! String).replacingOccurrences(of: "x", with: ""))!
    try save(render(Int(points * scale), fraction: 0.78, background: "FFF0DF"), catalog + (entry["filename"] as! String))
}
for appearance in ["dark", "tinted"] {
    let name = "Icon-App-\(appearance)-1024.png"
    try save(render(1024, fraction: 0.78, background: appearance == "dark" ? "28212E" : "202020", tinted: appearance == "tinted"), catalog + name)
    images.append(["idiom": "universal", "platform": "ios", "size": "1024x1024", "filename": name, "appearances": [["appearance": "luminosity", "value": appearance]]])
}
contents["images"] = images
try JSONSerialization.data(withJSONObject: contents, options: [.prettyPrinted, .sortedKeys]).write(to: catalogURL)

let res = "android/app/src/main/res/"
for (density, scale) in [("mdpi", 1.0), ("hdpi", 1.5), ("xhdpi", 2.0), ("xxhdpi", 3.0), ("xxxhdpi", 4.0)] {
    try save(render(Int(48 * scale), fraction: 0.78, background: "FFF0DF"), res + "mipmap-\(density)/ic_launcher.png")
    // Entire donut stays inside Android's circular 66dp safe zone.
    try save(render(Int(108 * scale), fraction: 60.0 / 108, background: nil), res + "mipmap-\(density)/ic_launcher_foreground.png")
    try save(render(Int(108 * scale), fraction: 60.0 / 108, background: nil, monochrome: true), res + "mipmap-\(density)/ic_launcher_monochrome.png")
}
try save(render(1024, fraction: 0.78, background: "FFF0DF"), "assets/app_icon/icon-light.png")
try save(render(1024, fraction: 0.78, background: "28212E"), "assets/app_icon/icon-dark.png")
try save(render(1024, fraction: 0.78, background: "202020", tinted: true), "assets/app_icon/icon-tinted.png")
print("Generated iOS light/dark/tinted icons and Android legacy/adaptive/monochrome icons.")
