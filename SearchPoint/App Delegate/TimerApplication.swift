//
//  TimerApplication.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 03/07/23.
//

import Foundation
import UIKit
class TimerApplication: UIApplication {

    // the timeout in seconds, after which should perform custom actions
    // such as disconnecting the user
  var counter = 60
  
    private var timeoutInSeconds: TimeInterval {
        // 2 minutes
        return 55 * 60
    }

  private  var idleTimer: Timer?

    // resent the timer because there was user interaction
    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }

        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                         target: self,
                                         selector: #selector(TimerApplication.timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
                                         
                                         
        )
    }

    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
              NotificationCenter.default.post(name: .appTimeout,
                                        object: nil
        )
    }
  

  override func sendEvent(_ event: UIEvent) {
    
    super.sendEvent(event)
    
    if idleTimer != nil {
      self.resetIdleTimer()
    }
    
    if let touches = event.allTouches {
      for touch in touches where touch.phase == UITouch.Phase.began {
        self.resetIdleTimer()
      }
    }
  }
  func stopTimer() {
         if let idleTimer = idleTimer {
             idleTimer.invalidate()
         }
     }
    
}

extension Notification.Name {

    static let appTimeout = Notification.Name("appTimeout")

}
