// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// MARK: - Fonts

internal enum FontFamily {
    internal enum SFProText {
        internal static let black = FontConvertible(name: "SFProText-Black", family: "SF Pro Text", path: "SF-Pro-Text-Black.otf")
        internal static let blackItalic = FontConvertible(name: "SFProText-BlackItalic", family: "SF Pro Text", path: "SF-Pro-Text-BlackItalic.otf")
        internal static let bold = FontConvertible(name: "SFProText-Bold", family: "SF Pro Text", path: "SF-Pro-Text-Bold.otf")
        internal static let boldItalic = FontConvertible(name: "SFProText-BoldItalic", family: "SF Pro Text", path: "SF-Pro-Text-BoldItalic.otf")
        internal static let heavy = FontConvertible(name: "SFProText-Heavy", family: "SF Pro Text", path: "SF-Pro-Text-Heavy.otf")
        internal static let heavyItalic = FontConvertible(name: "SFProText-HeavyItalic", family: "SF Pro Text", path: "SF-Pro-Text-HeavyItalic.otf")
        internal static let light = FontConvertible(name: "SFProText-Light", family: "SF Pro Text", path: "SF-Pro-Text-Light.otf")
        internal static let lightItalic = FontConvertible(name: "SFProText-LightItalic", family: "SF Pro Text", path: "SF-Pro-Text-LightItalic.otf")
        internal static let medium = FontConvertible(name: "SFProText-Medium", family: "SF Pro Text", path: "SF-Pro-Text-Medium.otf")
        internal static let mediumItalic = FontConvertible(name: "SFProText-MediumItalic", family: "SF Pro Text", path: "SF-Pro-Text-MediumItalic.otf")
        internal static let regular = FontConvertible(name: "SFProText-Regular", family: "SF Pro Text", path: "SF-Pro-Text-Regular.otf")
        internal static let regularItalic = FontConvertible(name: "SFProText-RegularItalic", family: "SF Pro Text", path: "SF-Pro-Text-RegularItalic.otf")
        internal static let semibold = FontConvertible(name: "SFProText-Semibold", family: "SF Pro Text", path: "SF-Pro-Text-Semibold.otf")
        internal static let semiboldItalic = FontConvertible(name: "SFProText-SemiboldItalic", family: "SF Pro Text", path: "SF-Pro-Text-SemiboldItalic.otf")
        internal static let thin = FontConvertible(name: "SFProText-Thin", family: "SF Pro Text", path: "SF-Pro-Text-Thin.otf")
        internal static let thinItalic = FontConvertible(name: "SFProText-ThinItalic", family: "SF Pro Text", path: "SF-Pro-Text-ThinItalic.otf")
        internal static let ultralight = FontConvertible(name: "SFProText-Ultralight", family: "SF Pro Text", path: "SF-Pro-Text-Ultralight.otf")
        internal static let ultralightItalic = FontConvertible(name: "SFProText-UltralightItalic", family: "SF Pro Text", path: "SF-Pro-Text-UltralightItalic.otf")
        internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, heavy, heavyItalic, light, lightItalic, medium, mediumItalic, regular, regularItalic, semibold, semiboldItalic, thin, thinItalic, ultralight, ultralightItalic]
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

    static func sfProTextBlack(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.black, size: size, relativeTo: textStyle)
    }
    static func sfProTextBlackItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.blackItalic, size: size, relativeTo: textStyle)
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
    static func sfProTextRegularItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.regularItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextSemibold(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.semibold, size: size, relativeTo: textStyle)
    }
    static func sfProTextSemiboldItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.semiboldItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextThin(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.thin, size: size, relativeTo: textStyle)
    }
    static func sfProTextThinItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.thinItalic, size: size, relativeTo: textStyle)
    }
    static func sfProTextUltralight(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.ultralight, size: size, relativeTo: textStyle)
    }
    static func sfProTextUltralightItalic(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle) -> Font {
        Font.custom(fontConvertible: FontFamily.SFProText.ultralightItalic, size: size, relativeTo: textStyle)
    }
}

private final class BundleToken {
    static let bundle: Bundle = {
        Bundle(for: BundleToken.self)
    }()
}


