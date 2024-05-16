import 'dart:async';

import 'package:al_quran/data/time_data.dart';
import 'package:al_quran/utils/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySliverAppBarSection extends StatefulWidget {
  final String formattedTime;
  const MySliverAppBarSection({super.key, required this.formattedTime});

  @override
  State<MySliverAppBarSection> createState() => _MySliverAppBarSectionState();
}

class _MySliverAppBarSectionState extends State<MySliverAppBarSection> {
  late Future<dynamic> _islamicDate;
  TimeAPI timeAPI = TimeAPI();
  late String _hijriDate = '';

  Future<void> getTime() async {
    await timeAPI.getTime();
    setState(() {
      _hijriDate = timeAPI.hijriDate;
    });
  }

  @override
  void initState() {
    _islamicDate = getTime();
    super.initState();
  }

  Widget _prayer_times(String name, IconData icon, String hour) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Text(
          hour,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 300.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(
              color: MyColor.mainColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: _islamicDate,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return Text(
                          _hijriDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                    },
                  ),
                  const Text(
                    "Tashkent, Uzbekistan",
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        widget.formattedTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Bomdod - 03:09",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _prayer_times(
                        "Bomdod",
                        Icons.sunny_snowing,
                        "04:41",
                      ),
                      _prayer_times(
                        "Peshin",
                        Icons.sunny,
                        "12:30",
                      ),
                      _prayer_times(
                        "Asr",
                        CupertinoIcons.sun_haze,
                        "16:14",
                      ),
                      _prayer_times(
                        "Shom",
                        CupertinoIcons.sun_dust,
                        "19:02",
                      ),
                      _prayer_times(
                        "Hufton",
                        CupertinoIcons.moon,
                        "19:40",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Spacer(),
                Opacity(
                  opacity: 0.4,
                  child: Image.asset("assets/images/background.png"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
