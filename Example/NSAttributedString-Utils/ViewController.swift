//
//  ViewController.swift
//  NSAttributedString-Utils
//
//  Created by benjdum59 on 04/23/2020.
//  Copyright (c) 2020 benjdum59. All rights reserved.
//

import UIKit
import NSAttributedString_Utils

class ViewController: UIViewController {
    @IBOutlet var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.boldSystemFont(ofSize: 17)
        let strings = ["(1)", "(3)"]
        label1.attributedText = label1.attributedText?.exponentize(searchTexts: strings, font: font, baselineOffset: 10)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

