//
//  Path.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/21/23.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
