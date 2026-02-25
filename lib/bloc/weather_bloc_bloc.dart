import 'package:bloc/bloc.dart';
import 'package:weather/weather.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        // Cihaz dilini belirleme
        String deviceLanguage = Platform.localeName.split('_')[0]; 
        Language weatherLanguage;

        switch (deviceLanguage) {
          case 'tr':
            weatherLanguage = Language.TURKISH;
            break;
          case 'fr':
            weatherLanguage = Language.FRENCH;
            break;
          default:
            weatherLanguage = Language.ENGLISH;
        }

        // WeatherFactory kurulumu
        WeatherFactory wf = WeatherFactory(
          "95821329c44a36c42635b2390900095b",
          language: weatherLanguage,
        );

        // Konum verisiyle hava durumunu çekme
        // event.position'ın null olmadığından emin oluyoruz
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude, 
          event.position.longitude,
        );

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        // Hatanın ne olduğunu VS Code terminalinde görmek için bu satır çok önemli:
        print("HAVA DURUMU HATASI: $e");
        emit(WeatherBlocFailure());
      }
    });
  }
}