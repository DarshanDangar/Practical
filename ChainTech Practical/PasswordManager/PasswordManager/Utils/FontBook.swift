//
//  FontBook.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 14/05/24.
//

import SwiftUI

enum SFPro: String {
    
    case black = "SFPRODISPLAYBLACKITALIC"
    case bold = "SFPRODISPLAYBOLD"
    case heavyItalic = "SFPRODISPLAYHEAVYITALIC"
    case lightItalic = "SFPRODISPLAYLIGHTITALIC"
    case ultraLightItalic = "SFPRODISPLAYULTRALIGHTITALIC"
    case medium = "SFPRODISPLAYMEDIUM"
    case regular = "SFPRODISPLAYREGULAR"
    case semiBoldItalic = "SFPRODISPLAYSEMIBOLDITALIC"
    case thinItalic = "SFPRODISPLAYTHINITALIC"
    
}

extension Font {
    
    static func customFont(_ font: SFPro, fontSize: CGFloat) -> Font {
        custom(font.rawValue, size: fontSize)
    }
    
}
