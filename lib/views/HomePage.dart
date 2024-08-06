import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/helper/helper.dart';
import 'package:weather_app/model/weather.dart';

import '../provider/connectivityprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final List<Weather> weatherDataList = [];

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (context, connectivityProvider, _) {
          if (connectivityProvider.isInternet) {
            return Stack(
              children: [
                Container(
                  color: Colors.blue.shade800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 300,
                        width: 370,
                        child: Container(
                          margin: EdgeInsets.only(top: 60),
                          child: TextField(
// onTapAlwaysCalled: true,
                            cursorColor: Colors.blue.shade800,
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Enter the name of city',
                              hintStyle: TextStyle(
                                color: Colors.blue.shade800,
                              ), // Hint text color
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.blue.shade800,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.blue.shade800,
                            ), // Text color
                            onSubmitted: (value) async {
                              final weatherData = await ApiHelpers.apiHelper
                                  .fetchData(Search: searchController.text);
                              if (weatherData != null) {
                                setState(() {
                                  weatherDataList.add(weatherData);
                                  searchController.clear();
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  height: MediaQuery.of(context).size.height / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: weatherDataList.length,
                    itemBuilder: (context, i) {
                      final data = weatherDataList[i];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('detail_page', arguments: data);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.locationName,
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.blue.shade800,
                                            ),
                                          ),
                                          Image.network(
                                            'https:${data.conditionIcon}',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${data.region}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "/${data.country}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("No Internet"),
            );
          }
        },
      ),
    );
  }
}
