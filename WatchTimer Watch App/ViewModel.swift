//
//  ViewModel.swift
//  WatchTimer Watch App
//
//  Created by Adam Reed on 9/25/23.
//

import Foundation

enum TimerStates {
    case ready
    case isRunning
}

class ViewModel: ObservableObject {
    var timer = Timer()
    @Published var currentTime: Int = 0
    @Published var timerState: TimerStates = .ready
    
    func runTimer() {
        if timerState == .ready {
            timerState = .isRunning
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.currentTime += 1
            }
        }
    }
    
    func stopTimer() {
        timerState = .ready
        self.timer.invalidate()
    }
}
