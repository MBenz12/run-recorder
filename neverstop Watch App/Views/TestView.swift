//
//  TestView.swift
//  neverstop Watch App
//
//  Created by admin on 10/26/23.
//

import SwiftUI

struct TestView: View {
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false


    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 5)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
                transaction.animation = Animation.easeInOut(duration: 2)
                self.completedLongPress = false;
            }
            .onEnded { finished in
                self.completedLongPress = finished
            }
    }
    var body: some View {
        VStack {
            Text("Stop")
                .frame(width: 100, height: 50, alignment: .center)
                .background(self.isDetectingLongPress ?
                            Color.red :
                            (self.completedLongPress ? Color.green : Color.blue))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(self.completedLongPress ? Color.green : Color.clear, lineWidth: 2)
                        .padding(2)
                )
                .cornerRadius(15)
                .scaleEffect(isDetectingLongPress ? 0.95 : 1.0)
                .gesture(longPress)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
