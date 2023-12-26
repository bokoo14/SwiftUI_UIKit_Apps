//
//  Memo.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/22/23.
//

import Foundation

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()
    
    var convertedDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}
