
import 'package:collectors/src/constants/image_strings.dart';


class PopulateTruckModel{
  final String model;
  final String plateNo;
  final String tonnageCapacity;
  final String driver;
  final String driverContact;
  final String pictures;

  PopulateTruckModel(this.model,this.plateNo,this.driver,this.driverContact,this.pictures,this.tonnageCapacity);

  static List<PopulateTruckModel> listTrucks = [
    PopulateTruckModel('Mitsubishi Fuso','KBZ 302H','Kenneth Otieno','0735024079',truck_1,'7 tonnes'),
    PopulateTruckModel('Isuzu FVZ','KCA 299Z','Catherine Mwalugha','0735024079',truck_2,'3.5 tonnes'),
    PopulateTruckModel('FAW','KAA 672','Purity Chepkemboi','0779350240',truck_3,'5 tonnes'),
    PopulateTruckModel('Kisauni Station','ST001','Mary Mbuche','0740793502',station_1,'300 m/sq'),
    PopulateTruckModel('Nyali Station','ST002','Chrispine Otieno','0740793502',station_2,'400 m/sq'),
    PopulateTruckModel('Mkomani Station','ST003','Maureen Mokeira','0793407502',station_3,'300 m/sq'),
    PopulateTruckModel('Bamburi Station','ST004','Chrispine Otieno','0740793502',station_4,'700 m/sq'),
  ];
}
