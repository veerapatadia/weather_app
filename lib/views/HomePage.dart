import 'package:flutter/material.dart';
import 'package:weather_app/helper/helper.dart';
import 'package:weather_app/model/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                // Expanded(
                //   child: TextField(
                //     controller: searchController,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(),
                //         hintText: "Search wallpaper..."),
                //   ),
                // ),
                // IconButton(
                //   icon: Icon(Icons.search),
                //   onPressed: () {
                //     getAllImages = ApiHelpers.apiHelper
                //         .fetchPhoto(searchItem: searchController.text);
                //     setState(() {});
                //   },
                // ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: FutureBuilder<Weather?>(
              future: ApiHelpers.apiHelper.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR: ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  Weather? data = snapshot.data;
                  return (data == null)
                      ? Center(
                          child: Text("No any data"),
                        )
                      : Text(data.locationName);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
