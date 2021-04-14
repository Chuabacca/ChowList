# ChowList
A simple list of restaurants fetched from an API.

## Description
This app is a demonstration of my understanding of MVVM (Model View View-Model) architecture. Although MVVM is not ideal for a small app, it demonstrates the advantages of separating business logic from the UI and the loosely coupled relationship between components. These aspects will increase reusability, maintainability, and testability as the app scales.

## Development Steps

### Define Requirements
* As a user, I should be able to see a list of restaurant names.
* As a user, when I tap on a specific name, I should see a map with the restaurant's location, name, and address in a separate vew.
* As a user, when I tap back, I should go back to the list of restaurants.

### Determine Basic App Architecture

```
- View Model
// Contains the data and data transformation functionality the app needs.
    - Data Model
        - name
        - address
        - longitude
        - latitude
- View
// Contains all of the UI configuration for the app.
    - UINavigationController
        - Display UITableView
        - Push DetailView onto the navigation stack
    - UITableViewCell
        - Display restaurant names
    - DetailView
        - Display restaurant location map
        - Display restaurant name and address
- Controller
// Contains functionality for displaying model data and user interactions
    - GetRestaurants
    // Calls the API when the app loads
        - Reload the view when API returns
    - Display Restaurant Details
    // Will pass the model to the detail view
- Service
// An additional layer that serves as an interface between the API and the view model. Allows for isolated updating if breaking changes are introduced to the API and for dependency injection for tests.
    - URLSession
    - JSON decoding
```

### Milestones
Sketch out the major development milestones to aid in planning, goal tracking, and setting expectations for stakeholders. 
1. API integration
    * Successfully connect to the API
    * Successfully decode JSON data
1. Data Modeling
    * Successfully present modeled data to the views
1. UI Construction
    * Successfully display the data in the app UI
1. Feature Testing
    * Ensure that the app fulfills all the requirements
    * Look for any remaining bugs (QA testing should happen regularly during development)
1. Tech Debt
    * Pay back tech debt accumulated during development
