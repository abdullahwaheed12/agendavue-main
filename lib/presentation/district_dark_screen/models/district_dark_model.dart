class DistrictDarkModel {
  DistrictDarkItemModel homeDarkItemList = (DistrictDarkItemModel(
    schoolName: "Montgomery County Public Schools",
    zipCode: "20902", //All tasks or Homework
    schoolAcronym: "MCPS",
  ));

  DistrictDarkModel({
    required this.schoolName,
    required this.zipCode,
    required this.schoolAcronym,
  });
  String schoolName;
  int zipCode;
  String schoolAcronym;

  factory DistrictDarkModel.fromJson(Map<String, dynamic> json) {
    return DistrictDarkModel(
      schoolName: json['id'],
      zipCode: json['name'],
      schoolAcronym: json['name'],
    );
  }
}

class DistrictDarkItemModel {
  DistrictDarkItemModel({
    required this.schoolName,
    required this.zipCode,
    required this.schoolAcronym,
  });

  String schoolName;
  String zipCode;
  String schoolAcronym;

  factory DistrictDarkItemModel.fromJson(Map<String, dynamic> json) {
    return DistrictDarkItemModel(
      schoolName: json['name'],
      zipCode: json['category'],
      schoolAcronym: json['subject'],
    );
  }
}
