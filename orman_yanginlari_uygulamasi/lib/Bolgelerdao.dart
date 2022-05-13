import 'package:orman_yanginlari_uygulamasi/Bolgeler.dart';
import 'package:orman_yanginlari_uygulamasi/VeritabaniYardimcisi.dart';

class Bolgelerdao{

  Future<List<Bolgeler>> tumBolgeler() async{

    var db= await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM bolgeler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Bolgeler(satir["bolge_id"],satir["bolge_ad"],satir["bolge_resim"],);
    });
  }

}