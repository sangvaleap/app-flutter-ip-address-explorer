# IP-Checker

This app enables users to check IP Address information including location, ISP, timezone, etc.

In version 1.0, the app includes such features as:
- IP Checking:
    - Get device's IP Address
    - Search for IP Address information
    - Display IP Address location on map
In version 2.0, new updates:
- Setting Page:
    - Theme Setting
    - Clear Cache
    - Map Setting
    - App Version
- Theme Modes:
    - Provide light and dark modes
    - Save user-chosen theme mode in cache
- Clear Cache:
    - Allow users to clear ip address information from cache
- Map Options:
    - Provide different map display modes (Open Street Provider and Google Map)
    - Save user-chosen map mode in cache

# Platforms
- iOS, Android, iPad, macOS

# Screenshots
<img width="1000" alt="Android" src="../../screenshots/screenshot.png">

# Development Setup
- flutter pub get
- flutter run

# API Document Generation
In root directory of the project, run: 
- dart doc . 
- The generated file is located at: ${project_directory}/doc/api/index.html

# Tools and Dependencies
- Dart: ^3.2.5
- Flutter: ^3.16.8
- bloc_test: ^9.1.5
- equatable: ^2.0.5
- flutter_bloc: ^8.1.3
- flutter_map: ^6.1.0
- flutter_svg: ^2.0.9
- geolocator: ^10.1.0
- http: ^1.2.0
- json_annotation: ^4.8.1
- latlong2: ^0.9.0
- mocktail: ^1.0.3
- network_info_plus: ^4.1.0
- shared_preferences: ^2.2.2

Dev Dependencies:
- flutter_lints: ^3.0.1
- json_serializable: ^6.7.1
- build_runner: ^2.4.8

# Styles
- Material Design 3
- Theme: Light mode
- Font: Rubik

# Testing
- Unit tests (model, cubit, state)
- Widget test (view)

# Project Structure
- ip_checker: Project directory
    - assets: Manages different types of assets
        - fonts: Contains font files used in the application
        - icons: Contains various types of icon files used in the application
        - images: Contains various types of image files used in the application
    - doc: Contains all generated document files, especially API document, of the project
    - lib: Contains Dart source code files that constitute the main logic and functionality of the application
        - core: Contains core functionality, including exception handling, services, theme management, and utility functions
            - exception: Contains custom exceptions for error handling
            - services: Includes services that depends on external libraries
            - style: Manages the overall theme of the application
            - utils: Holds utility classess and functions that can be used across the application
        - features: Contains feature-specific modules, with "ip_checker" as an example feature
            - ip_checker: IP Checker feature
                - cubit: Business logic and state management using Cubit pattern
                    - state: Defines the states that the Cubit can emit
                    - cubit: Implements the logic for handling state transitions
                - model: Contains data models specific to the "ip_checker" feature
                - repository: Manages data access for the "ip_checker" feature
                    - local: Handles local data storage and retrieval
                    - remote: Communicates with external APIs or services
                - view: User interface components related to "ip_checker" feature
                    - widgets: Contains reusable UI components specific to the IP Checker feature
        - common: Contains all common components
            - widgets: Contains reusable UI components that can be used accoss the app
    - screenshots: Contains screenshots of the app
    - test: Contains test files
        - ip_checker: Contains test files specifically related to the "ip_checker" feature
            - cubit: Contains test files for the Cubit pattern including state and cubit classes
            - helper: Contains test-related utility classes or functions that support the testing process for the feature
            - mock_data: Contains mock data used during testing of the feature
            - model: Contains test files for the data models
            - view: Contains test files related to the UI components

