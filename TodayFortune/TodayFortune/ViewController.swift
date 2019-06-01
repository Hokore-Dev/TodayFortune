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
    @IBOutlet weak var fortuneLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    var counter:Int = 1
    var session:WCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        currentTimeLabel.text = "\(year)년 \(month)월 \(day)일"
        
        onHttpRequest()
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
    
    func replace(main: String,target: String, withString: String) -> String { return main.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil) }
    
    func onHttpRequest() {
        
        //URL생성
        guard let url = URL(string: "http://erumyasp.azurewebsites.net/api/fortune_daily.php?tday=20190216&uday=19981026&lunar=1&monthType=1") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "get" //get : Get 방식, post : Post 방식
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            //error 일경우 종료
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            
            //data 가져오기
            if let _data = data {
                if let strData = NSString(data: _data, encoding: String.Encoding.utf8.rawValue) {
                    let str = String(strData)
                    //print(str)
                    //메인쓰레드에서 출력하기 위해
                    DispatchQueue.main.async {
                        print(str)
                        
                        self.fortuneLabel.text = self.replace(main: str, target: "<ul>", withString: "")
                    }
                }
            }else{
                print("data nil")
            }
        })
        task.resume()
    }
}

