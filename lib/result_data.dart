class Resultdata {
  final String id;
  final String gender;
  final String age;

  Resultdata({this.id = ' ', this.gender = ' ', this.age = ' '});

  factory Resultdata.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return Resultdata(
      id: id,
      gender: map['gender'] ?? ' ',
      age: map['age'] ?? ' ',
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["age"] = age;
    data["gender"] = gender;
    return data;
  }
}
