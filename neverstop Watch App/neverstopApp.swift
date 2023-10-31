//
//  neverstopApp.swift
//  neverstop Watch App
//
//  Created by admin on 10/24/23.
//

import SwiftUI

@main
struct neverstop_Watch_AppApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
        }
    }
}
