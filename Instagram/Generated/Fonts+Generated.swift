// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// MARK: - Fonts

internal enum FontFamily {
    internal enum SFProText {
        internal static let bold = FontConvertible(name: "SFProText-Bold", family: "SF Pro Text", path: "SF-Pro-Text-Bold.otf")
        internal static let boldItalic = FontConvertible(name: "SFProText-BoldItalic", family: "SF Pro Text", path: "SF-Pro-Text-BoldItalic.otf")
        internal static let heavy = FontConvertible(name: "SFProText-Heavy", family: "SF Pro Text", path: "SF-Pro-Text-Heavy.otf")
        internal static let heavyItalic = FontConvertible(name: "SFProText-HeavyItalic", family: "SF Pro Text", path: "SF-Pro-Text-HeavyItalic.otf")
        internal static let italic = FontConvertible(name: "SFProText-Italic", family: "SF Pro Text", path: "SF-Pro-Text-RegularItalic.otf")
        internal static let light = FontConvertible(name: "SFProText-Light", family: "SF Pro Text", path: "SF-Pro-Text-Light.otf")
        internal static let lightItalic = FontConvertible(name: "SFProText-LightItalic", family: "SF Pro Text", path: "SF-Pro-Text-LightItalic.otf")
        internal static let medium = FontConvertible(name: "SFProText-Medium", family: "SF Pro Text", path: "SF-Pro-Text-Medium.otf")
        internal static let mediumItalic = FontConvertible(name: "SFProText-MediumItalic", family: "SF Pro Text", path: "SF-Pro-Text-MediumItalic.otf")
        internal static let regular = FontConvertible(name: "SFProText-Regular", family: "SF Pro Text", path: "SF-Pro-Text-Regular.otf")
        internal static let semibold = FontConvertible(name: "SFProText-Semibold", family: "SF Pro Text", path: "SF-Pro-Text-Semibold.otf")
        internal static let semiboldItalic = FontConvertible(name: "SFProText-SemiboldItalic", family: "SF Pro Text", path: "SF-Pro-Text-SemiboldItalic.otf")
        internal static let all: [FontConvertible] = [bold, boldItalic, heavy, heavyItalic, italic, light, lightItalic, medium, mediumItalic, regular, semibold, semiboldItalic]
    }
}

// MARK: - Implementation Details
internal struct FontConvertible {
    internal let name: String
    internal let family: String
    internal let path: String
}

internal extension Font {
    static func custom(fontConvertible: FontConvertible, size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        return Font.custom(fontConvertible.name, size: UIFontMetrics(forTextStyle: textStyle).scaledValue(for: size))
    }

    static func sfProTextBold(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.bold, size: size, relativeTo: textStyle)
    }
    static func sfProTextBoldItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.boldItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextHeavy(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.heavy, size: size, relativeTo: textStyle)
    }
    static func sfProTextHeavyItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.heavyItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.italic, size: size, relativeTo: textStyle)
    }
    static func sfProTextLight(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.light, size: size, relativeTo: textStyle)
    }
    static func sfProTextLightItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.lightItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextMedium(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.medium, size: size, relativeTo: textStyle)
    }
    static func sfProTextMediumItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.mediumItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextRegular(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.regular, size: size, relativeTo: textStyle)
    }
    static func sfProTextSemibold(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.semibold, size: size, relativeTo: textStyle)
    }
    static func sfProTextSemiboldItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.semiboldItalic, size: size, relativeTo: textStyle)
    }
}

private final class BundleToken {
    static let bundle: Bundle = {
        Bundle(for: BundleToken.self)
    }()
}


