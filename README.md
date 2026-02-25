# 🌤️ Flutter Weather App (Minimalist & Modern)

A sleek and modern **Flutter** application that provides real-time weather updates based on the user's current location. Built with **Bloc (Business Logic Component)** architecture for a clean, scalable, and professional codebase.

![App Screenshot](https://via.placeholder.com/400x800?text=App+Screenshot) ## ✨ Features

* 📍 **Auto-Location:** Uses the `geolocator` package to fetch precise GPS coordinates.
* 🌡️ **Real-time Data:** Integrated with OpenWeatherMap API to provide temperature, "feels like" conditions, wind speed, and humidity.
* 🎨 **Dynamic UI:** Weather-specific icons and background effects that change based on conditions (Cloudy, Rainy, Sunny, etc.).
* 🌍 **Localization:** Automatically detects device language to provide data in Turkish, English, or French.
* 📅 **Detailed Info:** Displays sunrise, sunset, and current date in a beautiful, formatted layout.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
* **API:** [OpenWeatherMap API](https://openweathermap.org/)
* **Location:** [Geolocator](https://pub.dev/packages/geolocator)
* **Design:** Glassmorphism and Stack-based layered UI.

## 🚀 Installation & Setup

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/atkndmrcoglu/Weather_App.git](https://github.com/atkndmrcoglu/Weather_App.git)
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **API Key Configuration:**
    Navigate to `lib/bloc/weather_bloc_bloc.dart` and paste your OpenWeatherMap API Key in the designated field.
4.  **Run the app:**
    ```bash
    flutter run
    ```

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---
⭐ Feel free to star this repository if you found it helpful!
