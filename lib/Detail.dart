import 'package:dictionary_app/Kelimeler.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Kelimeler kelime;


  DetailPage({required this.kelime});

  //const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var ekranbilgisi = MediaQuery.of(context);
    final ekranyukseklik = ekranbilgisi.size.height;
    final ekrangenislik = ekranbilgisi.size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Detay Sayfası"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold,fontSize: ekrangenislik/10 ),),
              Text(widget.kelime.turkce,style: TextStyle(fontWeight: FontWeight.bold,fontSize: ekrangenislik/10 ),),

            ],
          ),
        ),
    );
  }
}
