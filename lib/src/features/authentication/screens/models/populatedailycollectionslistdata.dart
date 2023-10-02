
class PopulateCollectionsHouse{
  final String house;
  final int wet;
  final int dry;
  final String dates;

  PopulateCollectionsHouse(this.house,this.wet,this.dry,this.dates);

  static List<PopulateCollectionsHouse> listDailyCollections = [
    PopulateCollectionsHouse('HSE01',50,67,'01/01/2023'),
    PopulateCollectionsHouse('HSE02',60,77,'01/01/2023'),
    PopulateCollectionsHouse('HSE03',37,64,'01/01/2023'),
    PopulateCollectionsHouse('HSE04',30,46,'01/01/2023'),
    PopulateCollectionsHouse('HSE05',40,34,'02/01/2023'),
    PopulateCollectionsHouse('HSE06',90,67,'02/01/2023'),
    PopulateCollectionsHouse('HSE07',30,80,'02/01/2023'),
    PopulateCollectionsHouse('HSE08',79,67,'02/01/2023'),
  ];
}
