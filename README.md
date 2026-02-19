//
//  README.md
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 3/15/25.
//


LoopCraftApplication
LoopCraftApplication is a mobile and backend project for the LoopCraft app — a locally hosted LoopCraft server with an iOS client. It includes a Python static server for assets and an Xcode project for building the iOS app.
 About
This repository combines:
A simple HTTP server (Python) serving LoopCraft assets.
An iOS app (loopcraft) built in Xcode that consumes the local server content.
Test targets for unit and UI testing.
Getting Started
These instructions help you run the project locally.
 Prerequisites
Make sure you have installed:
Python 3.x
Xcode (latest recommended)
iOS Simulator or iOS device
  
 Running Locally
1. Start the Local LoopCraft Server
From your terminal:
# Activate your Python virtual environment
source venv/bin/activate

# Serve the 'catalog' directory on port 8000
cd catalog
python -m http.server 8000
Now the static content is available at:
http://localhost:8000/
2. Run the iOS App
Open the loopcraft.xcodeproj file in Xcode.
Select a Simulator or connected iOS device.
Build & run the app (⌘R).
The app should load content from your locally running LoopCraft server.
 How It Works
The Python HTTP server hosts web content (HTML/CSS/JS) that the iOS app loads.
The iOS app displays interactive content and integrates with native frameworks.
The project uses C, Swift, and Objective-C source files.
 Tests
Unit Tests: Located under loopcraftTests.
UI Tests: Located under loopcraftUITests.
Run tests via Xcode.
