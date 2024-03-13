# Easy Budget

Easy Budget is a personal finance management app developed in Flutter, which allows users to manage their expenses, budgets, and categories in a simple and efficient way.

## Main Features

- **User Authentication**: Allows users to log in with email/password, Google, or Facebook.
- **Category Management**: Allows users to add and manage categories to organize their expenses.
- **Budget Management**: Allows users to set monthly budgets for each category.
- **Expense Management**: Allows users to add new expenses with description, date, amount, and category.
- **Expense Viewing**: Provides a page to view all launched expenses, with filtering and sorting options.
- **Data Synchronization**: Synchronizes data between the internal database (Isar) and Firebase to ensure access to data even offline.

## Used Packages

- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter): Package for using icons from the FontAwesome library.
- [go_router](https://pub.dev/packages/go_router): Package for managing routes in the application.
- [isar](https://pub.dev/packages/isar) and [isar_flutter_libs](https://pub.dev/packages/isar_flutter_libs): Packages for using the Isar database.
- [path_provider](https://pub.dev/packages/path_provider): Package for handling file paths in the filesystem.
- [collection](https://pub.dev/packages/collection): Package for collection operations (lists, maps, etc.).
- [flex_color_scheme](https://pub.dev/packages/flex_color_scheme): Package for flexible and customizable color schemes.
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod): Package for state management in the Riverpod architecture.
- [intl](https://pub.dev/packages/intl): Package for internationalization and formatting of dates and numbers.
- [connectivity_plus](https://pub.dev/packages/connectivity_plus): Package for checking the device's network connectivity.
- [http](https://pub.dev/packages/http): Package for making HTTP requests.
- [firebase_auth](https://pub.dev/packages/firebase_auth), [firebase_core](https://pub.dev/packages/firebase_core), and [cloud_firestore](https://pub.dev/packages/cloud_firestore): Packages for Firebase integration, including user authentication and real-time data storage.

## How to Run the Application

To run Easy Budget on your device or emulator, follow these steps:

1. Clone this repository to your local machine.
2. Ensure you have the Flutter SDK installed on your machine.
3. Run `flutter pub get` in the terminal in the project folder to install dependencies.
4. Connect a device or start an emulator.
5. Run `flutter run` in the terminal in the project folder to start the application.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
