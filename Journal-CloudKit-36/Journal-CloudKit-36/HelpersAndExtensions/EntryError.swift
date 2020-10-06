//
//  EntryError.swift
//  Journal-CloudKit-36
//
//  Created by Shean Bjoralt on 10/5/20.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
}
