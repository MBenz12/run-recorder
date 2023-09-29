//
//  ContentView.swift
//  WatchTimer Watch App
//
//  Created by Adam Reed on 9/25/23.
//

import SwiftUI

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
        Text(text)
            .padding()
            .frame(minWidth: 120)
            .background(.blue)
            .cornerRadius(15)
    }
}

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack {
            TimerClockView(totalTime: vm.currentTime)

            switch vm.timerState {
            case .ready:
                TextThatLooksLikeButton(text: "Start")
                    .onTapGesture {
                        vm.runTimer()
                    }
                    
            case .isRunning:
                TextThatLooksLikeButton(text: "Hold to stop")
                    .onLongPressGesture {
                        vm.stopTimer()
                    }
            }
                
        }
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
