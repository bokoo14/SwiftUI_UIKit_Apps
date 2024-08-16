//
//  MyViewController.swift
//  KTV
//
//  Created by Bokyung on 8/16/24.
//

import UIKit

class MyViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileImageView.layer.cornerRadius = 5
    }

    // segue로 동작
    @IBAction func bookmarkDidTap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "bookmark", sender: nil)
    }

    // button으로 동작
    @IBAction func favoriteDidTap(_ sender: UIButton) { 
        print("favoriteDidTap")
    }
}
