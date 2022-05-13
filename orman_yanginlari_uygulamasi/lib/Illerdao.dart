import 'package:orman_yanginlari_uygulamasi/Bolgeler.dart';
import 'package:orman_yanginlari_uygulamasi/Ilceler.dart';
import 'package:orman_yanginlari_uygulamasi/Iller.dart';
import 'package:orman_yanginlari_uygulamasi/VeritabaniYardimcisi.dart';

class Illerdao{
  Future<List<Iller>> tumIllerByBolgeId(int bolge_id) async{

    var db= await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM iller,bolgeler,ilceler "
        "WHERE iller.bolge_id = bolgeler.bolge_id and iller.ilce_id = ilceler.ilce_id "
        "and iller.bolge_id =$bolge_id");

    return List.generate(maps.length, (indeks) {
      var satir = maps[indeks];

      var b = Bolgeler(satir["bolge_id"],satir["bolge_ad"],satir["bolge_resim"],);
      var ilc = Ilceler(satir["ilce_id"],satir["ilce_ad"]);
      var i = Iller(satir["il_id"],satir["il_ad"] ,satir["il_resim"] , b, ilc);
      return i;
    });
  }
}