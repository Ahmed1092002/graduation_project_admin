class CountryModel {
  int? countryId;
  String? countryName;

  CountryModel({this.countryId, this.countryName});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    return data;
  }
}
