//
//  ContentView.swift
//  neverstop Watch App
//
//  Created by admin on 10/24/23.
//

import SwiftUI
import HealthKit

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
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date(),
                                                     isPaused: workoutManager.session?.state == .paused)) { context in
                    ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0, showSubseconds: context.cadence == .live)
                }
                if workoutManager.running == false {
                    TextThatLooksLikeButton(text: "Start")
                        .onTapGesture {
                            workoutManager.selectedWorkout = .running;
                            workoutManager.togglePause()
                        }
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                }
                else {
                    TextThatLooksLikeButton(text: "Hold to stop")
                        .onLongPressGesture(minimumDuration: 5) {
                            //workoutManager.endWorkout()
                            workoutManager.togglePause()
                        }
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WorkoutManager())
    }
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool

    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
