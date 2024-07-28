import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> photos = [
    "https://i.pinimg.com/564x/de/d3/5b/ded35be77a9eb98ad803842e11847b57.jpg",
    "https://i.pinimg.com/564x/da/c6/4d/dac64dd3df6116648e9b799bb0e49cdc.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final Weather data = ModalRoute.of(context)!.settings.arguments as Weather;
    final photoUrl = photos[0];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(photoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_outlined),
                      color: Colors.white,
                    ),
                    Text(
                      "Weather Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  "Location: ${data.locationName}",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https:${data.conditionIcon}',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Location Time: ${data.localtime}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Region: ${data.region}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Country: ${data.country}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Temperature: ${data.tempC} °C / ${data.tempF} °F",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Condition: ${data.conditionText}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Wind: ${data.windKph} kph",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Humidity: ${data.humidity}%",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Cloud: ${data.cloud}%",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Feels Like: ${data.feelslikeC} °C / ${data.feelslikeF} °F",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
