//
//  ValidationPolicy.swift
//
//  Created by Cardasis, Jonathan (J.) on 6/14/16.
//  Copyright © 2016 Cardasis, Jonathan (J.). All rights reserved.
//

import Foundation

enum RegexPattern: String {
    //MARK: Characters
    case AlphaNumericAccentedCharacters = "[A-Za-z0-9 àâäæçèéêëîïôœùûüáéíóúüñ¿¡ºªÀÂÄÆÇÈÉÊËÍÏÔŒÙÛÜÁÉÍÓÚÜÑ]+"
    case AlphaNumericAccentedCharactersWithSpaces = "[A-Za-z0-9 àâäæçèéêëîïôœùûüáéíóúüñ¿¡ºªÀÂÄÆÇÈÉÊËÍÏÔŒÙÛÜÁÉÍÓÚÜÑ ]+"
    case AlphaNumericWithSymbolsAndSpaces = "[A-Za-z0-9 àâäæçèéêëîïôœùûüáéíóúüñ¿¡ºªÀÂÄÆÇÈÉÊËÍÏÔŒÙÛÜÁÉÍÓÚÜÑ!@#$%^&*(){}\":;\\\\/|'?,`~.\\-=\\+\\[\\] ]+"
    
    //MARK: Addresses
    case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    case IPAddress = "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    case URL = "(https?:\\\\\\/\\\\\\/)?([\\\\da-z\\\\.-]+)\\\\.([a-z\\\\.]{2,6})([\\\\\\/\\\\w \\\\.-]*)*\\\\\\/?"
    case ZipCodeUSA = "[0-9]{5}"
    case ZipCodeAsia = "[0-9]{6}"
    
    //MARK: Numbers
    case Numeric = "[0-9]+\\.?[0-9]*" //Whole and Decimal numbers
    case NumericWhole = "[0-9]+"
    case PhoneNumber = "[(]?[0-9]{3}[-.)]?[0-9]{3}[-.]?[0-9]{4}"
}

class ValidationPolicy {
    var pattern: RegexPattern
    
    init(conformsTo pattern: RegexPattern){
        self.pattern = pattern
    }
    
    /* Returns true if the entire string conforms to the pattern */
    func validateString(string: String) -> Bool{
        if NSPredicate(format: "SELF MATCHES %@", pattern.rawValue).evaluateWithObject(string) {
            return true
        }
        return false
    }
    
    /* Returns an array of ranges that are valid in the string for the current pattern */
    func validRangesInString(string: String) -> [NSRange] {
        if let regex = try? NSRegularExpression(pattern: pattern.rawValue, options: .AnchorsMatchLines) {
            let matches = regex.matchesInString(string, options: NSMatchingOptions.ReportProgress, range: NSRange(location: 0, length: string.characters.count))
            return matches.map{ $0.range }
        }
        return []
    }
}