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

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack {
            TimerClockView(totalTime: vm.currentTime)
            Button{
                // Start recording run
                
                vm.runTimer()
            } label: {
                Text("Start")
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
