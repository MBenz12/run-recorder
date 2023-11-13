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
                transaction.animation = Animation.linear(duration: 5)
                self.completedLongPress = false;
            }
            .onEnded { finished in
                self.completedLongPress = finished
            }
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hold to stop")
                    .font(.system(size: 25))
                    .gesture(longPress)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                    .background {
                        VStack {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.red.opacity(1.0))
                                .frame(maxWidth: isDetectingLongPress ? .infinity : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(Color.green.opacity(1.0))
                    }
                    .cornerRadius(15)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
