// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Attention!!!
  internal static let attention = L10n.tr("Localizable", "attention")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Celsius(°C)
  internal static let celsius = L10n.tr("Localizable", "celsius")
  /// Change region
  internal static let changeRegion = L10n.tr("Localizable", "changeRegion")
  /// Decoding error. Please contact us and report the problem.
  internal static let decodingError = L10n.tr("Localizable", "decodingError")
  /// Fahrenheit(°F)
  internal static let fahrenheit = L10n.tr("Localizable", "fahrenheit")
  /// Weather each 3 hours
  internal static let hourlyWeather = L10n.tr("Localizable", "hourlyWeather")
  /// Server error. Please contact us and report the problem.
  internal static let invalidRequestKey = L10n.tr("Localizable", "invalidRequestKey")
  /// Something went wrong. Please restart the app.
  internal static let locationNilKey = L10n.tr("Localizable", "locationNilKey")
  /// Please check your internet connection.
  internal static let network = L10n.tr("Localizable", "network")
  /// You've denied location authorization. Please go to Settings -> Privacy -> Location and allow access.
  internal static let noLocationPermissionKey = L10n.tr("Localizable", "noLocationPermissionKey")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "settings")
  /// Submit...
  internal static let submit = L10n.tr("Localizable", "submit")
  /// Temperature units
  internal static let temperatureUnits = L10n.tr("Localizable", "temperatureUnits")
  /// Today
  internal static let today = L10n.tr("Localizable", "today")
  /// Type city name...
  internal static let typeCityName = L10n.tr("Localizable", "typeCityName")
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
