import 'package:flutter/material.dart';
import 'package:orman_yanginlari_uygulamasi/Bolgeler.dart';
import 'package:orman_yanginlari_uygulamasi/DetaySayfa.dart';
import 'package:orman_yanginlari_uygulamasi/Ilceler.dart';

import 'package:orman_yanginlari_uygulamasi/Iller.dart';
import 'package:orman_yanginlari_uygulamasi/Illerdao.dart';

class IllerSayfa extends StatefulWidget {
  Bolgeler bolge;

  IllerSayfa({required this.bolge});

  @override
  _IllerSayfaState createState() => _IllerSayfaState();
}

class _IllerSayfaState extends State<IllerSayfa> {
  Future<List<Iller>> illeriGoster(int bolge_id) async {
    var illerListesi = await Illerdao().tumIllerByBolgeId(bolge_id);
    return illerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: Text("İller : ${widget.bolge.bolge_ad}"),
      ),
      body: FutureBuilder<List<Iller>>(
        //içerisinde bolgeler olan bir
        // liste getiricek liste dolu mu boş mu kontrolü
        future: illeriGoster(widget.bolge.bolge_id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var illerListesi =
                snapshot.data; //metdoun gönderdiği listeyi alıyoruz
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2/3.5,
              ),
              itemCount: illerListesi!.length,
              itemBuilder: (context, indeks) {
                //bolge listesinde kaç tane veri varsa sıratyla çalışır
                // sıraylaindeks numaralarını getiri
                var il = illerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa()
                                ));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("resimler/${il.il_resim}"),
                        ),
                        Text(il.il_ad,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
