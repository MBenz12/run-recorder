//
//  ContentView.swift
//  WatchTimer Watch App
//
//  Created by Adam Reed on 9/25/23.
//

import SwiftUI
import HealthKit

struct TimerClockView: View {
    let totalTime: Int
    var body: some View {
        HStack(spacing: 1) {
            if totalTime / 60 < 10 {
                Text("0\(totalTime / 60)")
            } else {
                Text((totalTime / 60).description)
            }
           
            Text(":")
            
            if totalTime % 60 < 10 {
                Text("0\(totalTime % 60)")
            } else {
                Text((totalTime % 60).description)
            }
        }
        .font(.title2)
    }
}

struct TextThatLooksLikeButton: View {
    let text: String
    var body: some View {
        GeometryReader { geometry in
            Text(text)
                .font(.system(size: 30))
                .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(Color.blue)
                            .cornerRadius(15)
                }
    }
}

struct ContentView: View {
    @StateObject var vm = ViewModel()
    private let healthStore = HKHealthStore()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                TimerClockView(totalTime: vm.currentTime)
                
                switch vm.timerState {
                case .ready:
                    TextThatLooksLikeButton(text: "Start")
                        .onTapGesture {
                            startRecording()
                        }
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                case .isRunning:
                    TextThatLooksLikeButton(text: "Hold to stop")
                        //.onTapGesture {
                        .onLongPressGesture(minimumDuration: 5) {
                            stopRecording()
                        }
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear() {
            authorizeHealthKit()
        }
    }
    
    private func startRecording() {
        vm.runTimer()
    }
    
    private func stopRecording() {
        vm.stopTimer()
    }
    
    private func authorizeHealthKit() {
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
//        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
//            if !success {
//                print("HealthKit authorization failed.")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
