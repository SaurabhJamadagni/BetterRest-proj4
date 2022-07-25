# BetterRest

This repo is for the project of [day 26](https://www.hackingwithswift.com/100/swiftui/26) of 100DaysOfSwiftUI by @twostraws.

## Overview

- This app takes the time when a user would like to wake up, how many hours of sleep they'll want and how many cups of coffee they have had.
- Using a ML model trained using Create ML, the app displays a bedtime for the user's provided information.
- This app was an introduction to Create ML.

## Structure of the app

- The app can be broken down into 4 sections.
  1. This section asks the user at what time they would like to wake up. Uses a DatePicker view, label hidden and Date ommitted.
  2. Second section asks the user how many hours of sleep they would like. A stepper is used that has a range of values 4...12
  3. The third section asks the user how many cups of coffee they had. The minimum value on this stepper is a 1 as otherwise the app is rendered irrelevant to the user.
     - The stepper was converted to a picker during the challenge day 28.
  4. The 4th section is also a challenge addition. It always shows the predicted bedtime of the user.
     - The core implementation had a calculate button in the navigation view that would call a `calculateButtonPressed` function.

## Learnings

- Learned how to train a ML model using a `.csv` data set in Create ML.
- Importing a ML model file into xcode automatically creates a class for it.
- Was able to practice basic UI layout concepts through this project.

[Link to my 100DaysOfSwiftUI repo](https://github.com/SaurabhJamadagni/100DaysOfSwiftUI)

Thanks for reading! Let's connect on [Twitter](https://twitter.com/Saura6hJ) 👋
