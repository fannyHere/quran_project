import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran/app/data/models/detail_surah.dart';
import 'package:quran/app/data/models/surah.dart';

void main() async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var res = await http.get(url);

  //print(res.body);
  //print("================================");
  //ini kan ngambil data secara keseluruhan dari API ya, nah klo mau ambil persatuan surahnya itu dibuat object
  //perlu diingat klo res.body itu berbentuk string maka harus diubah ke bentuk object://

  // var data = (json.decode(res.body) as Map<String, dynamic>);
  // print(data);
  //karena kebanyakan dan cuma pengen ambil bagian data aja yang berbentuk list:
  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  // print(data);
  // print(data[1]); //di indexing si surat al-fatihah

  //ubah ke model soalnya bisa jadi object yang bisa dibuat//

  //Surah dataSurah = Surah.fromJson(data); error
  //Masalah yang Anda alami disebabkan oleh perbedaan tipe data antara List dan Map.
  //Ketika Anda mencoba menggunakan Surah.fromJson(data),
  //fungsi fromJson mengharapkan sebuah Map<String, dynamic>, bukan List<dynamic>.
  //Inilah mengapa Anda perlu mengakses elemen individual dalam List tersebut,
  //seperti data[1], karena setiap elemen dalam List adalah Map<String, dynamic>.

  Surah dataSurah = Surah.fromJson(data[0]);
  // print(dataSurah.name);
  // print(dataSurah.name.transliteration.en);

  //////////////////////
  Uri urlAlfatihah =
      Uri.parse("https://api.quran.gading.dev/surah/${dataSurah.number}");
  var resAlfatihah = await http.get(urlAlfatihah);
  //print(resAlfatihah.body);
  //perlu diingat klo res.body itu berbentuk string maka harus diubah ke bentuk object:
  //print("====================================");

  Map<String, dynamic> dataAlfatihah =
      (json.decode(resAlfatihah.body) as Map<String, dynamic>)["data"];
  print(dataAlfatihah);
  print("======================");

  //ubah ke model soalnya bisa jadi object yang bisa dibuat//
  DetailSurah alfatihah = DetailSurah.fromJson(dataAlfatihah);

  print(alfatihah.verses[0].text.arab);
}
