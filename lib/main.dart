import 'dart:async';

import 'package:dictionary_app/Detail.dart';
import 'package:dictionary_app/Kelimeler.dart';
import 'package:dictionary_app/kelimelerdao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kelimegoster();
  }
  bool aramayapiliyormu = false;
  String aramakelimesi = "";

  Future<List<Kelimeler>> kelimegoster() async {
    var kelimelistesi = await kelimelerdao().veritabanigoster();
    return kelimelistesi;
  }

  Future<List<Kelimeler>> kelimearama() async {
    var kelimelistesi = await kelimelerdao().veritabaniarama(aramakelimesi);
    return kelimelistesi;
  }


  @override
  Widget build(BuildContext context) {

    var ekranbilgisi = MediaQuery.of(context);
    final ekranyukseklik = ekranbilgisi.size.height;
    final ekrangenislik = ekranbilgisi.size.width;



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: aramayapiliyormu ? TextField(decoration: InputDecoration(
          hintText: "Arama Yapmak için birşey yazınız."
        ),
        onChanged: (aramasonucu){
          print("arama sonucu: $aramasonucu");
          setState(() {
            aramakelimesi = aramasonucu;
          });
        },) : Text("Ana Sayfa"),
        actions: [
          aramayapiliyormu ? IconButton(icon: Icon(Icons.cancel),onPressed: (){
            setState(() {
              aramayapiliyormu = false;
              aramakelimesi = "";
            });

          }, ) : IconButton( icon: Icon(Icons.search),onPressed: (){
            setState(() {
              aramayapiliyormu = true;
            });

          },)
        ],


        leading: IconButton(tooltip: "Menu",icon: Icon(Icons.menu_book),onPressed: (){

      },),


      ),


      body: FutureBuilder<List<Kelimeler>>(future: aramayapiliyormu ? kelimearama() :kelimegoster(),builder: (context,snapshot){
        if (snapshot.hasData){
          var kelimelistesi = snapshot.data;
          return ListView.builder(
            itemCount: kelimelistesi!.length,
            itemBuilder: (context,indeks){
              var kelime = kelimelistesi[indeks];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(kelime : kelime)));
                },
                child: SizedBox(height: ekrangenislik/5,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${kelime.ingilizce}",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("=",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("${kelime.turkce}",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              );

            }

          );
        }else{
          return Center();
        }
      },

      ),
    );
  }
}
