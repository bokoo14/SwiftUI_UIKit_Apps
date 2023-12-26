//
//  PathType.swift
//  VoiceMemoApp
//
//  Created by Bokyung on 12/21/23.
//

enum PathType: Hashable {
    case homeView
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
