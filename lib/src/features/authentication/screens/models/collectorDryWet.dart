class User {
  final String collector;
  final int wet;
  final int dry;
  final String date;

  User({required this.collector,required this.wet,required this.dry,required this.date});

  static List<User> users = [
    User(collector: "Keneth Otieno", wet: 60, dry: 35, date: "04/06/2023"),
    User(collector: "Purity Chepkemboi", wet: 50, dry: 67, date: "22/06/2023"),
    User(collector: "Mary Mbuche", wet: 60, dry: 35, date: "05/06/2022"),
    User(collector: "Keneth Otieno", wet: 60, dry: 35, date: "05/06/2023"),
    User(collector: "Purity Chepkemboi", wet: 50, dry: 67, date: "22/06/2023"),
    User(collector: "Mary Mbuche", wet: 60, dry: 35, date: "05/06/2022"),
    User(collector: "Keneth Otieno", wet: 60, dry: 35, date: "04/06/2023"),
    User(collector: "Purity Chepkemboi", wet: 50, dry: 67, date: "22/06/2023"),
    User(collector: "Mary Mbuche", wet: 60, dry: 35, date: "05/06/2022"),
    User(collector: "Catherine Mwalugha", wet: 50, dry: 67, date: "22/06/2023")
  ];
  
}
