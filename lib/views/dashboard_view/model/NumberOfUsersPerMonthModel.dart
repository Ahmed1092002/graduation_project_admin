class NumberOfUsersPerMonthModel {
  String? yearMonth;
  int? count;

  NumberOfUsersPerMonthModel({this.yearMonth, this.count});

  NumberOfUsersPerMonthModel.fromJson(Map<String, dynamic> json) {
    yearMonth = json['yearMonth'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yearMonth'] = this.yearMonth;
    data['count'] = this.count;
    return data;
  }
}
