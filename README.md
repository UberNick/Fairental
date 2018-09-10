# Fairrental
***A fair way to find your next rental***

* Project board: https://trello.com/b/nwGxpun9/fairental

## API

Service API provided by [Amadeus API](https://sandbox.amadeus.com/).  Map and Location data is obtained through Apple's CoreLocation services.

## Assets

Images are open source from Material Design.  Some were manipulated for this project using Gimp.  All are free to reuse under Apache 2.0.

## Design Features

### Storyboards and AutoLayout
  * Suited for all-sized devices from iPhone SE through iPhone X
  * Functional on larger devices including all iPads

### Loosely-coupled components
  * Services communicate through Notifications
  * Common functionality written into protocol extensions
  * Notifiable / Listenable make posting and receiving easier
  * Standalone Service Delegates follow the Command pattern for Network calls
  * ViewModels to keep unnecessary display code and artifacts out of Controllers

### Use of native Swift 4 Codable domain models for data-serialization
  * Skipped Amadeus's Swagger-generated Swift objects for a cleaner, native approach
  * SearchRequest / SearchResponse both automatically resolves their entire object chain
  * New TimelessDate object better handles "2018-01-02" data marshaling
  * Parsing logic has good unit test coverage
