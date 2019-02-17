//
//  InterfaceController.swift
//  TodayFortune WatchKit Extension
//
//  Created by minjun.ha on 16/02/2019.
//  Copyright © 2019 thechamcham. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController , WCSessionDelegate {

    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var fortuneLabel: WKInterfaceLabel!
    
    var session:WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        session = WCSession.default
        session?.delegate = self
        session?.activate()
        
        onHttpRequest()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Watch WCSession Activated")
        case .notActivated:
            print("Watch WCSession Not Activated")
        case .inactive:
            print("Watch WCSession InActivated")
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let iphoneContext = applicationContext as? [String : Int] {
            if iphoneContext["Counter"] != nil {
                self.titleLabel.setText(String(iphoneContext["Counter"]!))
            }
        }
    }
    
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
                        
                        self.fortuneLabel.setText(str)
                    }
                }
            }else{
                print("data nil")
            }
        })
        task.resume()
    }
}
