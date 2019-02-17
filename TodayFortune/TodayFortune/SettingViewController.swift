//
//  SettingViewController.swift
//  TodayFortune
//
//  Created by minjun.ha on 17/02/2019.
//  Copyright © 2019 thechamcham. All rights reserved.
//

import UIKit
import WatchConnectivity

class SettingViewController : UIViewController {
   
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.white, forKey: "textColor")

    }
    @IBAction func buttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

