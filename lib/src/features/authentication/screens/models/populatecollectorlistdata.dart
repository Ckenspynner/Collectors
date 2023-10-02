
import 'package:collectors/src/constants/image_strings.dart';

class PopulateCollectorModel{
  final String title;
  final String phone;
  final String county;
  final String subcounty;
  final String ward;
  final String sublicense;
  final int wetKg;
  final int dryKg;
  final String pictures;

  PopulateCollectorModel(this.title,this.phone,this.county,this.subcounty,this.ward,this.sublicense,this.pictures,this.wetKg,this.dryKg);

  static List<PopulateCollectorModel> listcollectors = [
    PopulateCollectorModel('Kenneth Otieno','0702407935','Mombasa County','Kisauni','Shanzu','A03E4C01',truck_1,68,90),
    PopulateCollectorModel('Catherine Mwalugha','0735024079','Mombasa County','Kisauni','Bamburi','A03E4C02',truck_1,34,12),
    PopulateCollectorModel('Purity Chepkemboi','0779350240','Mombasa County','Nyali','Mkomani','A03E4C03',truck_1,40,20),
    PopulateCollectorModel('Mary Mbuche','0740793502','Mombasa County','Nyali','Kongowea','A03E4C04',truck_1,30,22),
    PopulateCollectorModel('Chrispine Otieno','0740793502','Mombasa County','Jomvu','Mikindani','A03E4C05',truck_1,20,15),
    PopulateCollectorModel('Maureen Mokeira','0793407502','Mombasa County','Changamwe','Miritin','A03E4C06',truck_1,78,34),
    PopulateCollectorModel('Evan Okoyo','0707934502','Mombasa County','Changamwe','Kipevu','A03E4C07',truck_1,44,32),
  ];
}
