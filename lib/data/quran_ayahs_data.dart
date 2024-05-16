import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class QuranAyahs {
  final int surahNumber;
  Map<int, String> surahArabic = {};
  Map<int, String> surahUzbek = {};
  String englishName = '';
  String arabicName = '';
  String currentSurahNumber = '';

  QuranAyahs(this.surahNumber);

  Future<void> getSurahs() async {
    try {
      String url =
          "http://api.alquran.cloud/v1/surah/$surahNumber/quran-sample";
      String urlUz = "http://api.alquran.cloud/v1/surah/$surahNumber/uz.sodik";

      final response = await http.get(Uri.parse(url));
      final responseUz = await http.get(Uri.parse(urlUz));

      if (response.statusCode == 200 && responseUz.statusCode == 200) {
        Map<String, dynamic> dataArabic = jsonDecode(response.body);
        Map<String, dynamic> dataUzbek = jsonDecode(responseUz.body);

        surahArabic = _parseAyahs(dataArabic['data']['ayahs']);
        surahUzbek = _parseAyahs(dataUzbek['data']['ayahs']);
        englishName = "${dataArabic['data']['englishName']}";
        arabicName = dataArabic['data']['name'];
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Map<int, String> _parseAyahs(List<dynamic> ayahs) {
    return {for (var ayah in ayahs) ayah['numberInSurah']: ayah['text']};
  }

  Map<String, String> getRandomAyah() {
    Random random = Random();
    int totalAyahs = surahArabic.length;
    int randomAyahIndex =
        random.nextInt(totalAyahs) + 1; // Generating a random index
    String? randomArabicAyahText = surahArabic[randomAyahIndex];
    String? randomUzbekAyahText = surahUzbek[randomAyahIndex];
    return {
      'arabic': randomArabicAyahText!,
      'uzbek': randomUzbekAyahText!,
      'number': randomAyahIndex.toString()
    };
  }
}

// void main(List<String> args) async {
//   QuranAyahs quranAPI =
//       QuranAyahs(1); // Change the surah number to the one you want
//   await quranAPI.getSurahs();

//   print(quranAPI.englishName);
//   Map<String, String> randomAyahs = quranAPI.getRandomAyah();
//   print('Arabic: ${randomAyahs['arabic']}');
//   print('Uzbek: ${randomAyahs['uzbek']}');
//   print("number: ${randomAyahs['number']}");
// }
