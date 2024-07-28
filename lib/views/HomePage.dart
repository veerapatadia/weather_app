import 'package:flutter/material.dart';
import 'package:weather_app/helper/helper.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/utils/alldata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final List<Weather> weatherDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weatherDataList.length,
                itemBuilder: (context, i) {
                  final data = weatherDataList[i];
                  final photoUrl = photos[i % photos.length];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('detail_page', arguments: data);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(photoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.locationName,
                                            style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white,
                                              backgroundColor: Colors.black54,
                                            ),
                                          ),
                                          Image.network(
                                            'https:${data.conditionIcon}',
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
