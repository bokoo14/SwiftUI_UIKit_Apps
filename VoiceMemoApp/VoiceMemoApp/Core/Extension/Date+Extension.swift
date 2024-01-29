//
//  Date+Extension.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/21/23.
//

import Foundation

extension Date {
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm" // 오전/오후 시간:분
        return formatter.string(from: self)
    }
    
    // MARK: 오늘인지, 다른 날짜인지 판별
    var formattedDay: String {
        let now = Date()
        let calendar = Calendar.current
        
        let nowStartDay = calendar.startOfDay(for: now)
        let dateStartOfDay = calendar.startOfDay(for: self)
        guard let numOfDayDifference = calendar.dateComponents([.day], from: nowStartDay, to: dateStartOfDay).day else {
            return "값 없음"
        }
        
        if numOfDayDifference == 0 {
            return "오늘"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "M월 d일 E요일"
            return formatter.string(from: self)
        }
    }
    
    var formattedVoiceRecorderTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.M.d"
        return formatter.string(from: self)
    }
}
