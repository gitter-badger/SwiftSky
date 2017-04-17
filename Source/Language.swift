//
//  Language.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Foundation

/**
 Used to describe a language compatible with the Dark Sky API
 
 ## Get the user's most preffered language
 `Language.userPreference`
 
 ## To get a specific language
 `Language.<language>` (eg. `Language.english`)
 
 ## A list of all current supported languages
 `Language.allLanguages`
 
 ## Available Languages
 ```swift
 arabic, azerbaijani, belarusian, bulgarian, bosnian,
 catalan, czech, german, greek, english, spanish,
 estonian, french, croatian, hungarian, indonesian,
 italian, icelandic, cornish, norwegian, dutch, polish,
 portuguese, russian, slovak, slovenian, serbian,
 swedish, tetum, turkish, ukrainian, igpayAtinlay,
 simplifiedChinese, traditionalChinese
 
*/
public struct Language {
    
    /// Short internal identifier for the language.
    /// Used when requesting `Forecast` from Dark Sky API.
    let shortcode : String
    
    /// `String` representing the human readable name of the language
    public let humanName : String
    
    /// An array of all Language's available
    public static let allLanguages = [
        arabic, azerbaijani, belarusian, bulgarian, bosnian, catalan, czech, german, greek, english, spanish, estonian, french,
        croatian, hungarian, indonesian, italian, icelandic, cornish, norwegian, dutch, polish, portuguese, russian, slovak,
        slovenian, serbian, swedish, tetum, turkish, ukrainian, igpayAtinlay, simplifiedChinese, traditionalChinese
    ]
    
    /// Represents the Language the user prefers
    public static var userPreference : Language {
        let preffered = Locale.preferredLanguages
        var currentLanguage : Language = .english
        var currentIndex : Int = .max
        for lang in Language.allLanguages {
            let i = preffered.index(of: lang.shortcode) ?? .max
            if i < currentIndex {
                currentIndex = i
                currentLanguage = lang
            }
        }
        return currentLanguage
    }
    
    /// Represents the Arabic Langauge
    public static let arabic = Language(shortcode: "ar", humanName: "Arabic")
    
    /// Represents the Azerbaijani Language
    public static let azerbaijani = Language(shortcode: "az", humanName: "Azerbaijani")
    
    /// Represents the Belarusian Language
    public static let belarusian = Language(shortcode: "be", humanName: "Belarusian")
    
    /// Represents the Bulgarian Language
    public static let bulgarian = Language(shortcode: "bg", humanName: "Bulgarian")
    
    /// Represents the Bosnian Language
    public static let bosnian = Language(shortcode: "bs", humanName: "Bosnian")
    
    /// Represents the Catalan Language
    public static let catalan = Language(shortcode: "ca", humanName: "Catalan")
    
    /// Represents the Czech Language
    public static let czech = Language(shortcode: "cs", humanName: "Czech")
    
    /// Represents the German Language
    public static let german = Language(shortcode: "de", humanName: "German")
    
    /// Represents the Greek Language
    public static let greek = Language(shortcode: "el", humanName: "Greek")
    
    /// Represents the English Language
    public static let english = Language(shortcode: "en", humanName: "English")
    
    /// Represents the Spanish Language
    public static let spanish = Language(shortcode: "es", humanName: "Spanish")
    
    /// Represents the Estonian Language
    public static let estonian = Language(shortcode: "et", humanName: "Estonian")
    
    /// Represents the French Language
    public static let french = Language(shortcode: "fr", humanName: "French")
    
    /// Represents the Croatian Language
    public static let croatian = Language(shortcode: "hr", humanName: "Croatian")
    
    /// Represents the Hungarian Language
    public static let hungarian = Language(shortcode: "hu", humanName: "Hungarian")
    
    /// Represents the Indonesian Language
    public static let indonesian = Language(shortcode: "id", humanName: "Indonesian")
    
    /// Represents the Italian Language
    public static let italian = Language(shortcode: "it", humanName: "Italian")
    
    /// Represents the Icelandic Language
    public static let icelandic = Language(shortcode: "is", humanName: "Icelandic")
    
    /// Represents the Cornish Language
    public static let cornish = Language(shortcode: "kw", humanName: "Cornish")
    
    /// Represents the Norwegian Bokmål Language
    public static let norwegian = Language(shortcode: "nb", humanName: "Norwegian Bokmål")
    
    /// Represents the Dutch Language
    public static let dutch = Language(shortcode: "nl", humanName: "Dutch")
    
    /// Represents the Polish Language
    public static let polish = Language(shortcode: "pl", humanName: "Polish")
    
    /// Represents the Portuguese Language
    public static let portuguese = Language(shortcode: "pt", humanName: "Portuguese")
    
    /// Represents the Russian Language
    public static let russian = Language(shortcode: "ru", humanName: "Russian")
    
    /// Represents the Slovak Language
    public static let slovak = Language(shortcode: "sk", humanName: "Slovak")
    
    /// Represents the Slovenian Language
    public static let slovenian = Language(shortcode: "sl", humanName: "Slovenian")
    
    /// Represents the Serbian Language
    public static let serbian = Language(shortcode: "sr", humanName: "Serbian")
    
    /// Represents the Swedish Language
    public static let swedish = Language(shortcode: "sv", humanName: "Swedish")
    
    /// Represents the Tetum Language
    public static let tetum = Language(shortcode: "tet", humanName: "Tetum")
    
    /// Represents the Turkish Language
    public static let turkish = Language(shortcode: "tr", humanName: "Turkish")
    
    /// Represents the Ukrainian Language
    public static let ukrainian = Language(shortcode: "uk", humanName: "Ukrainian")
    
    /// Represents the Igpay Atinlay Language
    public static let igpayAtinlay = Language(shortcode: "x-pig-latin", humanName: "Igpay Atinlay")
    
    /// Represents the simplified Chinese Language
    public static let simplifiedChinese = Language(shortcode: "zh", humanName: "simplified Chinese")
    
    /// Represents the traditional Chinese Language
    public static let traditionalChinese = Language(shortcode: "zh-tw", humanName: "traditional Chinese")
    
}
