//
//  TestView.swift
//  neverstop Watch App
//
//  Created by admin on 10/26/23.
//

import SwiftUI

struct TestView: View {
    @State var text: String = "hello!"
    
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false


    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 5)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
                transaction.animation = Animation.easeInOut(duration: 1)
                self.completedLongPress = false;
            }
            .onEnded { finished in
                self.completedLongPress = finished
            }
    }
    var body: some View {
        VStack {
            Text(isDetectingLongPress ? "Detecting" : "")
            Text(completedLongPress ? "Completed" : "")
            Button(action: {
                text = "action!"
            }) {
                Text("Start")
                    .frame(width: 100, height: 50, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .frame(width: 100, height: 50, alignment: .center)
            .cornerRadius(15)
            Text("Stop")
                .frame(width: 100, height: 50, alignment: .center)
                .background(self.isDetectingLongPress ?
                            Color.red :
                            (self.completedLongPress ? Color.green : Color.blue))
                .cornerRadius(15)
                .gesture(longPress)
                .scaleEffect(isDetectingLongPress ? 0.95 : 1.0)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
