import 'package:flutter/material.dart';
import 'package:orman_yanginlari_uygulamasi/Bolgeler.dart';
import 'package:orman_yanginlari_uygulamasi/Bolgelerdao.dart';
import 'package:orman_yanginlari_uygulamasi/IllerSayfa.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  Future<List<Bolgeler>> tunBolgeleriGoster() async{

    var bolgeListesi = await Bolgelerdao().tumBolgeler();

    return bolgeListesi;
  }//İçerisinde bolgeler(bolge nesnesi olan) sınıfında veri olan bir liste verecek

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bölgeler"),
      ),
      body: FutureBuilder<List<Bolgeler>>(//içerisinde bolgeler olan bir
        // liste getirecek liste dolu mu boş mu kontrolü
        future:  tunBolgeleriGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var bolgeListesi = snapshot.data;//metdoun gönderdiği listeyi alıyoruz
            return ListView.builder(
              itemCount: bolgeListesi!.length,

              itemBuilder: (context,indeks)
              {//bolge listesinde kaç tane veri varsa sıratyla çalışır
                // sıraylaindeks numaralarını getiri
                var bolge = bolgeListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IllerSayfa(bolge: bolge,)));
                  },
                  child: Card(
                    child:  SizedBox(height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(bolge.bolge_ad),
                        ],
                      ),
                    ),
                  ),
                );

              },
            );

          }else{
return Center();
          }
        },
      ),

    );
  }
}
