import 'package:dictionary_app/Kelimeler.dart';
import 'package:dictionary_app/veritabaniyardimcisi.dart';

class kelimelerdao{


  Future<List<Kelimeler>> veritabanigoster() async {
    var db = await veritabaniyardimcisi.veritabanierisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");
    
    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }

  Future<List<Kelimeler>> veritabaniarama(String aramakelimesi) async {
    var db = await veritabaniyardimcisi.veritabanierisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramakelimesi%' ");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }
}