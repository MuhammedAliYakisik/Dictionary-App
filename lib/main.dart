import 'package:dictionary_app/Detail.dart';
import 'package:dictionary_app/Kelimeler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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


  bool aramayapiliyormu = false;
  String aramakelimesi = "";



  Future<List<Kelimeler>> tumkelimeler() async {
    var kelimelistesi = <Kelimeler>[];

    var k1 = Kelimeler(1, "Dog", "Köpek");
    var k2 = Kelimeler(2, "Eraser", "Silgi");
    var k3 = Kelimeler(3, "Finger", "Parmak");

    kelimelistesi.add(k1);
    kelimelistesi.add(k2);
    kelimelistesi.add(k3);

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

      body: FutureBuilder<List<Kelimeler>>(future: tumkelimeler(),builder: (context,snapshot){
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
                child: SizedBox(height: ekrangenislik/7,
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
