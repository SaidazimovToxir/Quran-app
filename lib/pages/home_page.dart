// import 'dart:async';

// import 'package:al_quran/data/quran_ayahs_data.dart';
// import 'package:al_quran/pages/widgets/sliver_app_bar.dart';
// import 'package:al_quran/utils/my_style.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:intl/intl.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _SliverAppBarExampleState();
// }

// class _SliverAppBarExampleState extends State<HomePage> {
//   final videoUrl = "https://www.youtube.com/watch?v=moQtMet7F7w";
//   late YoutubePlayerController _controller;
//   late DateTime _currentDateTime = DateTime.now();

//   late Future<dynamic> _quranAhaysData;
//   QuranAyahs quranAyahs = QuranAyahs(1);
//   late Map<int, dynamic> _surahUzbek;
//   late Map<int, dynamic> _surahArabic;
//   String _englishName = '';
//   String _arabicName = '';
//   int _currentSurah = 1;
//   String _randomArabicText = '';
//   String _randomUzbekText = '';
//   String _ahaysNumber = '';

//   @override
//   void initState() {
//     final videoID = YoutubePlayer.convertUrlToId(videoUrl);

//     _controller = YoutubePlayerController(
//       initialVideoId: videoID!,
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         isLive: true,
//       ),
//     );
//     _updateDateTime();
//     Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateDateTime());
//     _quranAhaysData = getQuranAyahs();
//     super.initState();
//   }

//   void _updateDateTime() {
//     setState(() {
//       _currentDateTime = DateTime.now();
//     });
//   }

//   Future<void> getQuranAyahs() async {
//     await quranAyahs.getSurahs();
//     Map<String, String> randomAyahs = quranAyahs.getRandomAyah();
//     setState(() {
//       _surahArabic = quranAyahs.surahArabic;
//       _surahUzbek = quranAyahs.surahUzbek;
//       _arabicName = quranAyahs.arabicName;
//       _englishName = quranAyahs.englishName;
//       _ahaysNumber = randomAyahs['number']!;
//       _randomArabicText = randomAyahs['arabic']!;
//       _randomUzbekText = randomAyahs['uzbek']!;
//     });
//   }

//   @override
//   void dispose() {
//     print("Dispose ishlamoqda");
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenW = MediaQuery.of(context).size.width;
//     String formattedTime = DateFormat('HH:mm').format(_currentDateTime);
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           MySliverAppBarSection(formattedTime: formattedTime),
//           //* Sliver Items
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 top: 20.0,
//                 left: 20.0,
//                 right: 20.0,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "All Features",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const Gap(20),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     // spacing: 10.0,
//                     // runSpacing: 20.0,
//                     children: [
//                       AllFeaturesSection(
//                         imageIcon: "assets/icons/book_icon.png",
//                         title: "Quran",
//                       ),
//                       AllFeaturesSection(
//                         imageIcon: "assets/icons/volume_icon.png",
//                         title: "Azon",
//                       ),
//                       AllFeaturesSection(
//                         imageIcon: "assets/icons/compass_icon.png",
//                         title: "Qibla",
//                       ),
//                       AllFeaturesSection(
//                         imageIcon: "assets/icons/donation_icon.png",
//                         title: "Ehson",
//                       ),
//                       AllFeaturesSection(
//                         imageIcon: "assets/icons/menu_icon.png",
//                         title: "All",
//                       ),
//                     ],
//                   ),

//                   /// [Recomendation for days in the Quran]
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20.0),
//                     child: Text(
//                       "Quran syah of the day",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     clipBehavior: Clip.hardEdge,
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: MyColor.mainColor,
//                       borderRadius: BorderRadius.circular(20.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: MyColor.mainColor.withOpacity(0.9),
//                           offset: const Offset(3.0, 4.0),
//                           blurRadius: 12.0,
//                           spreadRadius: 2.0,
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           FutureBuilder(
//                             future: _quranAhaysData,
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text("ERROR: ${snapshot.error}");
//                               } else {
//                                 return Column(
//                                   children: [
//                                     ListTile(
//                                       title: Text(
//                                         _englishName,
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       subtitle: Text(
//                                         _arabicName,
//                                         style: const TextStyle(
//                                           color: Colors.white60,
//                                         ),
//                                       ),
//                                       trailing: Text(
//                                         "$_currentSurah/$_ahaysNumber",
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         print(
//                                             'Tapped on Quran ayahs section button');
//                                       },
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 16.0,
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             _randomArabicText,
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontFamily: "NotoNaskhArabic",
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               vertical: 10.0,
//                                             ),
//                                             child: Text(
//                                               _randomUzbekText,
//                                               overflow: TextOverflow.ellipsis,
//                                               maxLines: 2,
//                                               style: const TextStyle(
//                                                 color: Colors.white70,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   /// [End the Quran ayahs Recomentation section]

//                   const Gap(20),

//                   /// [Started live vidoe section]
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Text(
//                             "LIVE",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Container(
//                             width: 15,
//                             height: 15,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "View all",
//                           style: TextStyle(
//                             color: MyColor.mainColor,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Gap(16),

//                   /// [Get the live video]
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Container(
//                           width: screenW * 0.9,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20.0),
//                             child: YoutubePlayerBuilder(
//                               player: YoutubePlayer(
//                                 controller: _controller,
//                               ),
//                               builder: (context, player) {
//                                 return player;
//                               },
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AllFeaturesSection extends StatelessWidget {
//   final String imageIcon;
//   final String title;

//   const AllFeaturesSection({
//     super.key,
//     required this.imageIcon,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print(title);
//       },
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               color: MyColor.mainColor,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Image.asset(
//                 imageIcon,
//                 color: Colors.white,
//                 width: 30,
//                 height: 30,
//               ),
//             ),
//           ),
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:al_quran/data/quran_ayahs_data.dart';
import 'package:al_quran/pages/widgets/sliver_app_bar.dart';
import 'package:al_quran/utils/my_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final videoUrl = "https://www.youtube.com/watch?v=moQtMet7F7w";
  late YoutubePlayerController _controller;
  late DateTime _currentDateTime = DateTime.now();

  late Future<dynamic> _quranAhaysData;
  late QuranAyahs quranAyahs;
  late Map<int, dynamic> _surahUzbek = {};
  late Map<int, dynamic> _surahArabic = {};
  String _englishName = '';
  String _arabicName = '';
  int _currentSurah = 1;
  String _randomArabicText = '';
  String _randomUzbekText = '';
  String _ahaysNumber = '';

  @override
  void initState() {
    super.initState();
    _initializeYoutubePlayer();
    _startDateTimeUpdater();
    _loadQuranAyahsData();
  }

  void _initializeYoutubePlayer() {
    final videoID = YoutubePlayer.convertUrlToId(videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        isLive: true,
      ),
    );
  }

  void _startDateTimeUpdater() {
    Timer.periodic(const Duration(seconds: 1), (_) => _updateDateTime());
  }

  void _updateDateTime() {
    setState(() {
      _currentDateTime = DateTime.now();
    });
  }

  Future<void> _loadQuranAyahsData() async {
    quranAyahs = QuranAyahs(1);
    await quranAyahs.getSurahs();
    final randomAyahs = quranAyahs.getRandomAyah();

    setState(() {
      _surahArabic = quranAyahs.surahArabic;
      _surahUzbek = quranAyahs.surahUzbek;
      _arabicName = quranAyahs.arabicName;
      _englishName = quranAyahs.englishName;
      _ahaysNumber = randomAyahs['number']!;
      _randomArabicText = randomAyahs['arabic']!;
      _randomUzbekText = randomAyahs['uzbek']!;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('HH:mm').format(_currentDateTime);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppBarSection(formattedTime: formattedTime),
          SliverToBoxAdapter(
            child: _buildFeaturesSection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "All Features",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          _buildAllFeaturesRow(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Quran syah of the day",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildQuranAyahsRecommendation(),
          const Gap(20),
          _buildLiveVideoSection(screenW),
        ],
      ),
    );
  }

  Widget _buildAllFeaturesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final feature in features)
          AllFeaturesSection(
            imageIcon: feature['icon']!,
            title: feature['title']!,
          ),
      ],
    );
  }

  Widget _buildQuranAyahsRecommendation() {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: MyColor.mainColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: MyColor.mainColor.withOpacity(0.9),
            offset: const Offset(3.0, 4.0),
            blurRadius: 12.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                _englishName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                _arabicName,
                style: const TextStyle(
                  color: Colors.white60,
                ),
              ),
              trailing: Text(
                "$_currentSurah/$_ahaysNumber",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                print('Tapped on Quran ayahs section button');
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Text(
                    _randomArabicText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "NotoNaskhArabic",
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Text(
                      _randomUzbekText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveVideoSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text(
                  "LIVE",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: TextStyle(
                  color: MyColor.mainColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller,
                    ),
                    builder: (context, player) {
                      return player;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AllFeaturesSection extends StatelessWidget {
  final String imageIcon;
  final String title;

  const AllFeaturesSection({
    Key? key,
    required this.imageIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(title);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: MyColor.mainColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                imageIcon,
                color: Colors.white,
                width: 30,
                height: 30,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

final List<Map<String, String>> features = [
  {
    'title': 'Quran',
    'icon': 'assets/icons/book_icon.png',
  },
  {
    'title': 'Azon',
    'icon': 'assets/icons/volume_icon.png',
  },
  {
    'title': 'Qibla',
    'icon': 'assets/icons/compass_icon.png',
  },
  {
    'title': 'Ehson',
    'icon': 'assets/icons/donation_icon.png',
  },
  {
    'title': 'All',
    'icon': 'assets/icons/menu_icon.png',
  },
];
