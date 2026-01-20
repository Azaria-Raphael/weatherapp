// import 'dart:convert';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:weatherapp/additional_info_item.dart';
// import 'package:weatherapp/hourly_forecast_item.dart';
// import 'package:http/http.dart' as http;
// import 'package:weatherapp/secrets.dart';

// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({super.key});

//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   late Future<Map<String, dynamic>> weather;
//   Future<Map<String, dynamic>> getCurrentWeather() async {
//     const cityName = 'Dar%20es%20Salaam';

//     try {
//       final uri = Uri.https("api.openweathermap.org", "/data/2.5/forecast", {
//         "q": cityName,
//         "units": "metric",
//         "appid": openWeatherAPIkey,
//       });
//       final response = await http.get(uri);

//       //sever error handling
//       if (response.statusCode != 200) {
//         throw Exception("Sever error: ${response.statusCode}");
//       }

//       final data = jsonDecode(response.body);
//       if (data['cod'] != '200') {
//         throw Exception(data['message']);
//       }

//       return data;
//     } catch (e) {
//       throw Exception('Something went wrong');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     weather = getCurrentWeather();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Dar es Salaam",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 weather = getCurrentWeather();
//               });
//             },
//             icon: Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: weather,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: const CircularProgressIndicator.adaptive());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           }

//           final data = snapshot.data!;
//           IconData getWeatherIcon(String main) {
//             switch (main) {
//               case 'Clear':
//                 return Icons.wb_sunny;

//               case 'Clouds':
//                 return Icons.cloud;

//               case 'Rain':
//               case 'Drizzle':
//                 return Icons.grain;

//               case 'Thunderstorm':
//                 return Icons.flash_on;

//               case 'Snow':
//                 return Icons.ac_unit;

//               case 'Mist':
//               case 'Smoke':
//               case 'Haze':
//               case 'Dust':
//               case 'Fog':
//               case 'Sand':
//               case 'Ash':
//                 return Icons.blur_on;

//               case 'Squall':
//               case 'Tornado':
//                 return Icons.cyclone;

//               default:
//                 return Icons.help_outline;
//             }
//           }

//           // data from API on the first card
//           final currentTemp = data['list'][0]['main']['temp'];

//           // final currentSky = data['list'][0]['weather'][0]['main'];
//           final currentSkyMain = data['list'][0]['weather'][0]['main'];
//           final currentSkyDescription =
//               data['list'][0]['weather'][0]['description'];

//           // additional information
//           final currentPressure = data['list'][0]['main']['pressure'];
//           final currentHumidity = data['list'][0]['main']['humidity'];
//           final currentWindSpeed = data['list'][0]['wind']['speed'];

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //main card
//                 SizedBox(
//                   width: double.infinity,
//                   child: Card(
//                     elevation: 10,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               Text(
//                                 // '300.67 °K', this is placeholder vaule
//                                 '$currentTemp °C',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Icon(
//                                 getWeatherIcon(currentSkyMain),
//                                 size: 48,
//                                 color: Colors.blue,
//                               ),

//                               const SizedBox(height: 16),
//                               Text(
//                                 "$currentSkyDescription",
//                                 style: TextStyle(fontSize: 25),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 Text(
//                   "Hourly Forecast",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),

//                 // the hourly forecast section is commented out for now
//                 //because it is building 40 components which will slow down
//                 //the app due to perfomance issues

//                 // SingleChildScrollView(
//                 //   scrollDirection: Axis.horizontal,
//                 //   child: Row(
//                 //     children: [
//                 //       for (int i = 0; i < 39; i++)
//                 //         HourlyForecastItem(
//                 //           time: data['list'][i + 1]['dt'].toString(),
//                 //           icon:
//                 // data['list'][i + 1]['weather'][0]['main'] ==
//                 //         "Clouds" ||
//                 //     data['list'][i + 1]['weather'][0]['main'] ==
//                 //         "Rain"
//                 // ? Icons.cloud
//                 // : Icons.sunny,
//                 //           temperature: data['list'][i + 1]['main']['temp']
//                 //               .toString(),
//                 //         ),
//                 //     ],
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 120,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 39,
//                     itemBuilder: (context, index) {
//                       final hourlyforecast = data['list'][index + 1];
//                       final hourlySkyicon =
//                           data['list'][index + 1]['weather'][0]['main'];
//                       final time = DateTime.parse(
//                         hourlyforecast['dt_txt'].toString(),
//                       );
//                       return HourlyForecastItem(
//                         time: DateFormat.jm().format(time),
//                         temperature: hourlyforecast['main']['temp'].toString(),
//                         // icon:
//                         //     hourlySkyicon == "Clouds" || hourlySkyicon == "Rain"
//                         //     ? Icons.cloud
//                         //     : Icons.sunny,
//                         icon: getWeatherIcon(hourlySkyicon),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Additional Information",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     AdditionalInfoItem(
//                       icon: Icons.water_drop,
//                       label: "Humidity",
//                       value: currentHumidity.toString(),
//                     ),
//                     AdditionalInfoItem(
//                       icon: Icons.speed,
//                       label: "Wind Speed",
//                       value: currentWindSpeed.toString(),
//                     ),
//                     AdditionalInfoItem(
//                       icon: Icons.stacked_line_chart,
//                       label: "Pressure",
//                       value: currentPressure.toString(),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/additional_info_item.dart';
import 'package:weatherapp/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    const cityName = "Dar es Salaam";

    try {
      final uri = Uri.https("api.openweathermap.org", "/data/2.5/forecast", {
        "q": "$cityName,TZ",
        "units": "metric",
        "appid": openWeatherAPIkey,
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception("Server error (${response.statusCode})");
      }

      final data = jsonDecode(response.body);

      if (data["cod"] != "200") {
        throw Exception(data["message"]);
      }

      return data;
    }
    //  no internet
    on SocketException {
      throw Exception("No internet connection");
    }
    // timeout
    on TimeoutException {
      throw Exception("Connection timeout");
    }
    //  unknown
    catch (e) {
      throw Exception("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dar es Salaam",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          //  error UI
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 70, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    snapshot.error.toString().replaceAll("Exception:", ""),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        weather = getCurrentWeather();
                      });
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          final data = snapshot.data!;

          IconData getWeatherIcon(String main) {
            switch (main) {
              case 'Clear':
                return Icons.wb_sunny;
              case 'Clouds':
                return Icons.cloud;
              case 'Rain':
              case 'Drizzle':
                return Icons.grain;
              case 'Thunderstorm':
                return Icons.flash_on;
              case 'Snow':
                return Icons.ac_unit;
              case 'Mist':
              case 'Smoke':
              case 'Haze':
              case 'Dust':
              case 'Fog':
              case 'Sand':
              case 'Ash':
                return Icons.blur_on;
              case 'Squall':
              case 'Tornado':
                return Icons.cyclone;
              default:
                return Icons.help_outline;
            }
          }

          final currentTemp = data['list'][0]['main']['temp'];
          final currentSkyMain = data['list'][0]['weather'][0]['main'];
          final currentSkyDescription =
              data['list'][0]['weather'][0]['description'];

          final currentPressure = data['list'][0]['main']['pressure'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MAIN CARD
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
                                "$currentTemp °C",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                getWeatherIcon(currentSkyMain),
                                size: 48,
                                color: Colors.blue,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentSkyDescription,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Hourly Forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 39,
                    itemBuilder: (context, index) {
                      final hourlyforecast = data['list'][index + 1];
                      final hourlySky = hourlyforecast['weather'][0]['main'];

                      final time = DateTime.parse(hourlyforecast['dt_txt']);

                      return HourlyForecastItem(
                        time: DateFormat.jm().format(time),
                        temperature: hourlyforecast['main']['temp'].toString(),
                        icon: getWeatherIcon(hourlySky),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
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
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.speed,
                      label: "Wind Speed",
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.stacked_line_chart,
                      label: "Pressure",
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
