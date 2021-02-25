// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Decoding error. Please contact us and report the problem.
  internal static let decodingError = L10n.tr("Localizable", "decodingError")
  /// Server error. Please contact us and report the problem.
  internal static let invalidRequestKey = L10n.tr("Localizable", "invalidRequestKey")
  /// Something went wrong. Please restart the app.
  internal static let locationNilKey = L10n.tr("Localizable", "locationNilKey")
  /// Please check your internet connection.
  internal static let network = L10n.tr("Localizable", "network")
  /// You've denied location authorization. Please go to Settings -> Privacy -> Location and allow access.
  internal static let noLocationPermissionKey = L10n.tr("Localizable", "noLocationPermissionKey")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
