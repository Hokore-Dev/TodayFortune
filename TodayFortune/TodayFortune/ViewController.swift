//
//  ViewController.swift
//  TodayFortune
//
//  Created by minjun.ha on 16/02/2019.
//  Copyright © 2019 thechamcham. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    @IBOutlet weak var textField: UILabel!
    
    var counter:Int = 1
    var session:WCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func buttonPressed(_ sender: Any) {
        counter += 1
        textField.text = String(counter)
        let iPhoneAppContext = ["Counter": counter]
        do {
            try session?.updateApplicationContext(iPhoneAppContext)
        } catch {
            print("Something went wrong")
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Phone WCSession Activated")
        case .notActivated:
            print("Phone WCSession Not Activated")
        case .inactive:
            print("Phone WCSession InActivated")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session went inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session deactivated")
    }
}

