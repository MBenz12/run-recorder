# Neverstop Run Recorder

Neverstop run recorder - never lose an activity again.

Activity recording stop/start/edit is entirely your hands.neverstop run recorder. never lose an activity again. activity recording stop/start/edit is entirely your hands.

<img width="50%" src="https://user-images.githubusercontent.com/50103/271848852-695fb7b5-3b6f-4a52-ada1-e4c7b90d397a.png">

## MVP

- large single button to start recording
- large single button, which requires pressing and holding for n seconds to end recording
- integrates into HealthKit via the activity recording API

## User Stories

General
- As a user, I know all my recordings will be integrated into the Healthkit system
- As a user, I know I can use the app to record runs without fear of accidentally ending a recording

Recording a run
- As a user, I can start a recording by touching a very large button without fear of hitting any other buttons
- As a user, I can stop a recording by holding down a very large button
- As a user, I can reset the recording back to zero by stopping the current recording

## HealthKit integration

Initial version just has HK start recording a run and stop recording a run.

Future ideas
- If HK allows recording activities but not immediately saving them to OS-level datastore, then we could offer an ability to evaluate whether or not to "save" an activity to the HK store upon finishing a recording. Because once it's finalized in HK, you can't really take it back or undo - it gets sent out to all the other integrations, Strava, whatever.
- Offer different activities instead of just running
- Offer editing, merges and splits

## Future User Experience

The "one thing done well" approach is the MVP: Record a run, using an app that isn't a footgun for fucking up the recording. Instead it's designed for the opposite - design for all the threats, the ways a recording could be messed up.

However, we can expand the core feature set in a few dimensions without moving away from the core value proposition.

Dimension 1: Expand what is recorded

Current default is running.

But we could...

  - Add a selector for activities
  - Sort activities by frecency
  - Defaults to last activity (or could add some temporal smarts based on frecency metadata)

Dimension 2: Expand what is displayed

Current display is time elapsed in the recording.

But we could...

- Add a selector for display values, such as heart rate, zone, distance, etc
- Or show a few of those all at the same time
- Or make four quadrants that act like mini widgets, and each one is a selector of what value to show, so the user can decide what is displayed and where
