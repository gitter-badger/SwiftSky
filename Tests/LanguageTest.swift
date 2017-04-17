//
//  LanguageTest.swift
//  SwiftSky
//
//  Created by Luca Silverentand on 11/04/2017.
//  Copyright © 2017 App Company.io. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftSky

class LanguageTest : QuickSpec {
    
    let languageDictionary : [String:String] = [
        "ar" : "Arabic",
        "az" : "Azerbaijani",
        "be" : "Belarusian",
        "bg" : "Bulgarian",
        "bs" : "Bosnian",
        "ca" : "Catalan",
        "cs" : "Czech",
        "de" : "German",
        "el" : "Greek",
        "en" : "English",
        "es" : "Spanish",
        "et" : "Estonian",
        "fr" : "French",
        "hr" : "Croatian",
        "hu" : "Hungarian",
        "id" : "Indonesian",
        "it" : "Italian",
        "is" : "Icelandic",
        "kw" : "Cornish",
        "nb" : "Norwegian Bokmål",
        "nl" : "Dutch",
        "pl" : "Polish",
        "pt" : "Portuguese",
        "ru" : "Russian",
        "sk" : "Slovak",
        "sl" : "Slovenian",
        "sr" : "Serbian",
        "sv" : "Swedish",
        "tet" : "Tetum",
        "tr" : "Turkish",
        "uk" : "Ukrainian",
        "x-pig-latin" : "Igpay Atinlay",
        "zh" : "simplified Chinese",
        "zh-tw" : "traditional Chinese"
    ] 
    
    func findKeyForValue(value: String, dictionary: [String: String]) ->String? {
        for (key, val) in dictionary {
            if val == value {
                return key
            }
        }
        return nil
    }
    
    override func spec() {
        
        describe("languages") {
            
            context("api default language", {
                it("should be") {
                    expect(SwiftSky.language.shortcode).to(equal(Language.english.shortcode))
                }
            })
            
            context("list of all languages", {
                it("should contain") {
                    var contains : [String] = []
                    for lang in Language.allLanguages {
                        contains.append(lang.shortcode)
                    }
                    expect(contains).to(contain(Array(self.languageDictionary.keys)))
                }
            })
            
            context("shortcodes to names", {
                it("should be") {
                    for lang in Language.allLanguages {
                        expect(lang.humanName).to(equal(self.languageDictionary[lang.shortcode]))
                    }
                }
            })
            
            context("names to shortcodes", {
                it("should be") {
                    for lang in Language.allLanguages {
                        expect(lang.shortcode).to(equal(self.findKeyForValue(value: lang.humanName, dictionary: self.languageDictionary)))
                    }
                }
            })
            
        }
        
    }
    
}
