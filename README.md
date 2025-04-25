# City Search App

## Approach

To solve the search problem, I implemented a `filter` in SwiftUI that dynamically updates the list of cities based on the user's input. The search is case-insensitive and updates in real-time as the user types. The list also supports an option to show only favorite cities.

## Important Decisions and Assumptions

- **Local Data Source:** I assumed the list of cities would be loaded locally (e.g., from a local JSON or static array) instead of fetching it from an external API.
- **SwiftUI for UI:** I used SwiftUI for building the main views to simplify layout and improve performance, hosting it inside a `UIViewController` for compatibility.
- **Coordinator Pattern:** I applied the Coordinator pattern to manage navigation, assuming that the project may scale in the future.
- **Favorites State:** Favorites are managed in-memory for now, without persistent storage, assuming this was out of the current scope.
- **Simple Search:** I considered a basic "prefix" match for the search functionality instead of implementing a full-text or fuzzy search engine.
