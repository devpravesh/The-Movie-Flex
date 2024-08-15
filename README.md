
# The Movie Flex

The Movie Flex is a Flutter-based application that provides users with information about movies, including top-rated, popular, and upcoming films. The app fetches data from The Movie Database (TMDb) API, offering detailed movie information such as release dates, genres, ratings, and more.

## Features

- **Top Rated Movies:** View a list of the top-rated movies.
- **Popular Movies:** Explore the most popular movies currently trending.
- **Upcoming Movies:** Stay updated with movies that are soon to be released.
- **Movie Details:** Access detailed information about any movie, including genres, production companies, runtime, and more.
- **Collections:** See if a movie belongs to a collection and view related movies.
- **Homepage Links:** Visit the official homepage of movies (if available).

## Screenshots

(Add screenshots of your app here)

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio or VSCode with Flutter extensions

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/devpravesh/The-Movie-Flex.git
   cd the_movie_flex
   ```

2. **Install Dependencies:**

   ```bash
   flutter pub get
   ```

3. **API Key Configuration:**

   - Obtain an API key from [The Movie Database (TMDb)](https://www.themoviedb.org/documentation/api).
   - Add your API key in the app by updating the `NetworkClient` class or the configuration file where the API key is required.

4. **Run the App:**

   ```bash
   flutter run
   ```

### Usage

- Browse through different categories like top-rated, popular, and upcoming movies.
- Tap on any movie to view detailed information, including its plot, release date, and production details.
- Use the homepage link to visit the movie's official site (if available).

### Video Demonstration

For a video demonstration of the app, click the link below:

[Watch the Video](./screenrecord.mp4)

## Dependencies

- `get`: For state management and routing.
- `dio`: For making network requests.
- `url_launcher`: For launching URLs in the device browser.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to [TMDb](https://www.themoviedb.org/) for providing the movie data.
