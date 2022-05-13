import 'package:orman_yanginlari_uygulamasi/Bolgeler.dart';
import 'package:orman_yanginlari_uygulamasi/Ilceler.dart';

class Iller{
  int il_id;
  String il_ad;
  String il_resim;

  Bolgeler bolge;
  Ilceler ilce;

  Iller(this.il_id, this.il_ad, this.il_resim, this.bolge, this.ilce);
}