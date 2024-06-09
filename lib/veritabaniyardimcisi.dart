import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class veritabaniyardimcisi{

  static final String veritabaniadi = "kelimeler.sqlite";

  static Future<Database> veritabanierisim() async {
    String veritabaniyolu = join(await getDatabasesPath(),veritabaniadi);

    if(await databaseExists(veritabaniyolu)){
      print("veri tabanı var ");
    }else{

      ByteData data = await rootBundle.load("veritabani/$veritabaniadi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniyolu).writeAsBytes(bytes,flush: true);
      print("veri tabanı kopyalandı");


    }
    return openDatabase(veritabaniyolu);
  }

}