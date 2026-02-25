import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // İkon belirleme fonksiyonunu geliştirdik
  Widget getWeatherIcon(int code) {
    return switch (code) {
      >= 200 && < 300 => Image.asset('assets/1.png', scale: 8),
      >= 300 && < 400 => Image.asset('assets/2.png', scale: 8),
      >= 500 && < 600 => Image.asset('assets/3.png', scale: 8),
      >= 600 && < 700 => Image.asset('assets/4.png', scale: 8),
      >= 700 && < 800 => Image.asset('assets/5.png', scale: 8),
      800             => Image.asset('assets/6.png', scale: 8),
      > 800 && <= 804 => Image.asset('assets/7.png', scale: 8),
      _               => Image.asset('assets/8.png', scale: 8),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 146, 229, 239),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Arka plan dekorasyonları
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlueAccent),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlueAccent),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(decoration: const BoxDecoration(color: Colors.transparent)),
              ),

              // Veri Yönetimi
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SingleChildScrollView( // Taşmaları önlemek için eklendi
                      child: Column(
                        children: [
                          Text(
                            state.weather.areaName ?? "Bilinmiyor",
                            style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Merhaba!',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                          ),
                          // Dinamik ikon kullanımı
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              '${state.weather.temperature?.celsius?.round() ?? 0}°C',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 55),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain?.toUpperCase() ?? "",
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Text(
                              DateFormat('EEEE, dd MMM').add_jm().format(state.weather.date!),
                              style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 30),
                          
                          // Gün doğumu ve batımı
                          _buildWeatherRow(
                            'assets/11.png', 'Gündoğumu', DateFormat().add_jm().format(state.weather.sunrise!),
                            'assets/12.png', 'Günbatımı', DateFormat().add_jm().format(state.weather.sunset!),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Divider(color: Colors.white, thickness: 0.5),
                          ),
                          
                          // Min ve Max Sıcaklık
                          _buildWeatherRow(
                            'assets/14.png', 'Minimale', '${state.weather.tempMin?.celsius?.round()}°C',
                            'assets/13.png', 'Maximale', '${state.weather.tempMax?.celsius?.round()}°C',
                          ),
                        ],
                      ),
                    );
                  } else if (state is WeatherBlocLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  } else if (state is WeatherBlocFailure) {
                    return const Center(child: Text("Hava durumu yüklenemedi!", style: TextStyle(color: Colors.white)));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Row'ları daha temiz hale getirmek için yardımcı widget
  Widget _buildWeatherRow(String icon1, String label1, String val1, String icon2, String label2, String val2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSmallInfo(icon1, label1, val1),
        _buildSmallInfo(icon2, label2, val2),
      ],
    );
  }

  Widget _buildSmallInfo(String icon, String label, String value) {
    return Row(
      children: [
        Image.asset(icon, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ],
    );
  }
}