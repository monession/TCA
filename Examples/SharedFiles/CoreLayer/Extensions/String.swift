//
//  String.swift
//  tca-examples
//
//  Created by incetro on 12/12/23.
//

import Foundation

// MARK: - String

extension String {

    private static func funnyString(preferredLength: Int) -> String {
        /// without 'y'
        let vowels = ["e","a","u","i","o"]
        /// without 'q'
        let consonants = ["b","c","d","f","g","h","j","k","l","m","n","p","r","s","t","v","w","x","z"]
        return (0..<preferredLength).map { index in
            index % 2 == 0
            ? consonants[Int(arc4random() % UInt32(consonants.count))]
            : vowels[Int(arc4random() % UInt32(vowels.count))]
        }.joined()
    }

    static var generatedName: String {
        funnyString(preferredLength: 8)
    }

    static func generatedText(wordsCount: Int = 5) -> String {
        let preferredLength = [3, 4, 5, 6, 7, 8]
        return (0..<wordsCount).map { _ in
            funnyString(preferredLength: preferredLength.randomElement().unsafelyUnwrapped)
        }.joined(separator: " ")
    }
}
