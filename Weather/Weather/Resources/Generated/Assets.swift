// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let brightGray = ColorAsset(name: "Bright Gray")
  internal static let charade = ColorAsset(name: "Charade")
  internal static let electricViolet = ColorAsset(name: "Electric Violet")
  internal static let hotPink = ColorAsset(name: "Hot Pink")
  internal static let malibu = ColorAsset(name: "Malibu")
  internal static let manatee2 = ColorAsset(name: "Manatee 2")
  internal static let manatee = ColorAsset(name: "Manatee")
  internal static let midGray = ColorAsset(name: "Mid Gray")
  internal static let mischka = ColorAsset(name: "Mischka")
  internal static let mountainMist = ColorAsset(name: "Mountain Mist")
  internal static let trout = ColorAsset(name: "Trout")
  internal static let menu = ImageAsset(name: "menu")
  internal static let cloudyDay2 = ImageAsset(name: "cloudy day 2")
  internal static let cloudyDay3 = ImageAsset(name: "cloudy day 3")
  internal static let cloudyNight1 = ImageAsset(name: "cloudy night 1")
  internal static let cloudyNight2 = ImageAsset(name: "cloudy night 2")
  internal static let cloudyNight3 = ImageAsset(name: "cloudy night 3")
  internal static let cloudy = ImageAsset(name: "cloudy")
  internal static let day = ImageAsset(name: "day")
  internal static let night = ImageAsset(name: "night")
  internal static let rainy1 = ImageAsset(name: "rainy 1")
  internal static let rainy2 = ImageAsset(name: "rainy 2")
  internal static let rainy3 = ImageAsset(name: "rainy 3")
  internal static let rainy4 = ImageAsset(name: "rainy 4")
  internal static let rainy5 = ImageAsset(name: "rainy 5")
  internal static let rainy6 = ImageAsset(name: "rainy 6")
  internal static let rainy7 = ImageAsset(name: "rainy 7")
  internal static let snowy1 = ImageAsset(name: "snowy 1")
  internal static let snowy2 = ImageAsset(name: "snowy 2")
  internal static let snowy3 = ImageAsset(name: "snowy 3")
  internal static let snowy4 = ImageAsset(name: "snowy 4")
  internal static let snowy5 = ImageAsset(name: "snowy 5")
  internal static let snowy6 = ImageAsset(name: "snowy 6")
  internal static let thunder = ImageAsset(name: "thunder")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
