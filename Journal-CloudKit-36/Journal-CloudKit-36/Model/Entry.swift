//
//  Entry.swift
//  Journal-CloudKit-36
//
//  Created by Shean Bjoralt on 10/5/20.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let recordTypeKey = "Entry"
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
    static let ckRecordIDKey = "ckRecordID"
}

class Entry {
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.titleKey] as? String, let body = ckRecord[EntryConstants.bodyKey] as? String, let timestamp = ckRecord[EntryConstants.timestampKey] as? Date else { return nil }
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordTypeKey, recordID: entry.ckRecordID)
        self.setValuesForKeys([
            EntryConstants.titleKey : entry.title,
            EntryConstants.bodyKey : entry.body,
            EntryConstants.timestampKey : entry.timestamp,
//            EntryConstants.ckRecordIDKey : entry.ckRecordID
        ])
    }
}


