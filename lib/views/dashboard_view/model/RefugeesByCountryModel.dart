class RefugeesByCountryModel {
  String? countryName;
  int? count;

  RefugeesByCountryModel({this.countryName, this.count});

  RefugeesByCountryModel.fromJson(Map<String, dynamic> json) {
    countryName = json['countryName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryName'] = this.countryName;
    data['count'] = this.count;
    return data;
  }
}
