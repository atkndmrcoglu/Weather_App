import 'package:flutter/material.dart';
import 'package:weather_app/Screens/home_screen.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          // 1. HATA KONTROLÜ (Eğer konum alınamazsa burası çalışır)
          if (snap.hasError) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hata: ${snap.error}\n\nLütfen konum servislerini ve izinlerini kontrol edin.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          }

          // 2. VERİ GELDİĞİNDE (Konum başarıyla alındıysa)
          if (snap.hasData) {
            return BlocProvider<WeatherBlocBloc>(
              create: (context) => WeatherBlocBloc()
                ..add(FetchWeather(snap.data as Position)),
              child: const HomeScreen(),
            );
          } 
          
          // 3. YÜKLEME EKRANI (Konum bekleniyorsa)
          else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Konum servisleri kapalı. Lütfen ayarlardan açın.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Konum izni reddedildi.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Konum izinleri kalıcı olarak reddedilmiş. Ayarlardan manuel açmanız gerekir.');
  }

  return await Geolocator.getCurrentPosition();
}