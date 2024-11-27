
# GitHub Events Viewer

This is a simple iOS application that fetches GitHub events from the GitHub Events API and displays them in a list. It allows users to view and filter events by type, and automatically refreshes the list every 10 seconds.



## Technologies Used

- Swift – Main programming language.
- Combine – Reactive programming for handling asynchronous events and data binding.
- SnapKit – Auto Layout library used to define constraints programmatically in the app.
- NetworkService – A service to fetch GitHub events from the GitHub API.
- MVVM – Architectural pattern used to separate the concerns of UI and business logic.
## API Reference
  Base URL: https://api.github.com

#### Get events

```http
  GET /events
```


## Features

- Fetches GitHub events using URLSession and displays them in a list.
- Filters events by type (e.g., PushEvent, IssuesEvent, etc.).
- Updates the event list every 10 seconds automatically.
- Displays event details such as the event type, actor (user), and the associated repository.
- Uses Combine framework for handling asynchronous data fetching and UI updates.
- Simple MVVM architecture for clean and maintainable code.
- Dark mode support.
- iPhone and iPad support.

## Code Structure

- NetworkService: Responsible for fetching events from the GitHub API using URLSession. It decodes the events into a model array of GitHubEvent objects.

- GitHubEvent: A model representing a GitHub event. Each event contains details like the event type, actor, and associated repository.

- ViewModel (EventsListViewModel): Contains the logic for fetching events, filtering them based on the event type, and updating the view accordingly. It uses Combine's @Published properties to notify the UI of changes.


## Key Concepts

- MVVM Architecture: The app uses Model-View-ViewModel (MVVM) design pattern to separate business logic from UI code. This makes the code more maintainable and testable.

- Combine Framework: This project uses Combine to handle asynchronous data streams. It provides powerful tools for handling events, network requests, and UI updates reactively.

- Timer for Auto-Refresh: A Timer is used to periodically update the event list every 10 seconds.
## What’s Left to Be Done / Improvements

- Unit Testing: No unit tests have been written yet. Adding tests for the ViewModel, NetworkService, and filtering logic would improve reliability.

- Error Handling: Improve error handling by showing user-friendly messages instead of just logging errors to the console.

- UI Enhancements: Improve the UI with more detailed views or advanced filtering options.

- Hard-Coding Texts: Move hard-coded texts into localized files or constants for better maintainability and flexibility.