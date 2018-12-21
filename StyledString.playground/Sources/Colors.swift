import UIKit
import StyledString

// Colors

private func uicolor(hex: Int32) -> UIColor {
    return UIColor(
        red: CGFloat((hex >> 16) & 0xff) / 255.0,
        green: CGFloat((hex >> 8) & 0xff) / 255.0,
        blue: CGFloat(hex & 0xff) / 255.0,
        alpha: 1
    )
}

public extension UIColor {

    static let cabaret = uicolor(hex: 0xd2527f)
    static let pomegranate = uicolor(hex: 0xf03434)
    static let radicalRed = uicolor(hex: 0xf62459)
    static let valencia = uicolor(hex: 0xd64541)
    static let softRed = uicolor(hex: 0xec644b)
    static let zest = uicolor(hex: 0xe47833)
    static let seaBuckthorn = uicolor(hex: 0xeb974e)
    static let saffronMango = uicolor(hex: 0xfabe58)
    static let capeHoney = uicolor(hex: 0xfde3a7)
}

