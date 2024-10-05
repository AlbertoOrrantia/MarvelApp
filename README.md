Simple native iOS application built entirely with Swift, consuming the Marvel API. This app focuses on showcasing Marvel characters by utilizing the Marvel API's characters endpoint.


Features


Character Listing: View a grid of Marvel characters with images and names fetched from the Marvel API.

Search: Search for specific Marvel characters by name.

Character Details: Tap a character to view detailed information, including an image, name, and description.

Favorites: Add characters to your favorites list, view them in a separate section, and manage your favorite characters.

Lazy Loading: Fetch more characters when you scroll down, improving the user experience.



Views


Home View: Displays a grid of Marvel characters.

Search View: Allows searching for characters by name.

Character Detail View: Provides character details and the option to add to favorites.

Favorites View: Displays your favorite characters and allows you to remove them from the list.


Requirements

To run this project locally, you'll need to add your Marvel API keys to a "Secrets.plist" file. 
Add your own keys under the following entries:
  - MARVEL_PUBLIC_KEY
  - MARVEL_PRIVATE_KEY

