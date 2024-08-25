//
//  SeekbarView.swift
//  KTV
//
//  Created by Bokyung on 8/25/24.
//

import UIKit

protocol SeekbarViewDelegate: AnyObject {
    func seekbar()
}

class SeekbarView: UIView {
    @IBOutlet weak var totalPlayTimeView: UIView!
    @IBOutlet weak var playablePlayTimeView: UIView!
    @IBOutlet weak var currentPlayTimeView: UIView!
    @IBOutlet weak var playableTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var playTimeWidth: NSLayoutConstraint!

    private(set) var totalPlayTime: Double = 0
    private(set) var playableTime: Double = 0
    private(set) var currentPlayTime: Double = 0

    weak var delegate: SeekbarViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.totalPlayTimeView.layer.cornerRadius = 1
        self.playablePlayTimeView.layer.cornerRadius = 1
        self.currentPlayTimeView.layer.cornerRadius = 1
    }

    func setTotalPlayTime(_ totalPlayTime: Double) {
        self.totalPlayTime = totalPlayTime
    }

    func setPlayTime(_ playTime: Double, playableTime: Double) {
        self.currentPlayTime = playTime
        self.playableTime = playableTime
    }

    private func update() {
        guard self.totalPlayTime > 0 else {
            return
        }

        self.playableTimeWidth.constant = self.widthForTime(self.currentPlayTime)
        self.playTimeWidth.constant = self.widthForTime(self.playableTime)

        // 애니메이션
        UIView.animate(
            withDuration: 0.2
        ) {
            self.layoutIfNeeded()
        }
    }

    private func widthForTime(_ time: Double) -> CGFloat {
        min(self.frame.width, self.frame.width * time / self.totalPlayTime)
    }
}
