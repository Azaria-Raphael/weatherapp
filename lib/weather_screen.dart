import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/additional_info_item.dart';
import 'package:weatherapp/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300.67 °K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Icon(Icons.cloud, size: 64),
                          const SizedBox(height: 16),
                          Text("Rain", style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Weather Forecast",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(
                    time: "00:00",
                    icon: Icons.cloud,
                    temperature: "320.11",
                  ),
                  HourlyForecastItem(
                    time: "01:00",
                    icon: Icons.sunny,
                    temperature: "322.52",
                  ),
                  HourlyForecastItem(
                    time: "02:00",
                    icon: Icons.cloud,
                    temperature: "302.33",
                  ),
                  HourlyForecastItem(
                    time: "03:00",
                    icon: Icons.cloud,
                    temperature: "323.44",
                  ),
                  HourlyForecastItem(
                    time: "04:00",
                    icon: Icons.sunny,
                    temperature: "324.55",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Additional Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: "92%",
                ),
                AdditionalInfoItem(
                  icon: Icons.speed,
                  label: "Wind Speed",
                  value: "12 km/h",
                ),
                AdditionalInfoItem(
                  icon: Icons.stacked_line_chart,
                  label: "Pressure",
                  value: "1008",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
