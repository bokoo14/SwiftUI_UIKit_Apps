//
//  KVOObject.swift
//  KVO
//
//  Created by Lecture on 2023/09/14.
//

import Foundation

// NSObject를 상속해야 함
class KVOObject: NSObject {
    
    @objc dynamic var value: Int = 0
}
