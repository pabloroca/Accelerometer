
## Main specs:

Overview
--------

Write an iOS app that listens to the accelerometer sensor and computes 3 features over this data. The features should be computed in Swift. The results of this computation should be displayed in the user interface of the app.


Goal
----

The goal of the exercise is to produce readable and correct code. The user interface does not have to be fancy.


Requirements
------------

* The app should sample accelerometer at 20 Hz (every 50 ms).

* The app should calculate the following three features:

    - Descriptive statistics (max, median, mean, stdev, min, count) over the last 5 seconds.

    - Descriptive statistics (max, median, mean, stdev, min, count) since app start.

    - Amount of zero-crossings (when a measured value switches from positive to negative and vice versa) over the last 5 seconds.

* The features should be calculated separately for the X, Y and Z direction of an accelerometer measurement.

* The computed features should be made visible in the app. It is more important  to have readable, working and correct code than it is to have a fancy UI.
