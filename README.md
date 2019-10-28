# Wikipedia Locations Test App
Assesment task for ABN-Amro
by Adam Lovastyik

## Building and running
Simply open the projecty file with [Xcode](https://itunes.apple.com/us/app/xcode/id497799835)

## Testing
Run unit tests from Xcode

## Localization
This app uses base localization that can be extended

# Modifications in Wikipedia App
As part of the assesment some changes have been made to the original app

## Custom URL
App can be opened with a custom location using this scheme `wikipedia://places/LACoorinate/(latitude),(longitude)`

## Code changes
Custom code changes in oroiginal source code

### NSUserActrivity+WMFExtensions.m
line 85: Parsing LACoordinate URL component to coordinates

### WMFAppViewController.m
line 1247: Show location on map in places tab

### PlacesViewController.swift
line 2275: Create annotation and add to map and show alert dialog with location coordinate
