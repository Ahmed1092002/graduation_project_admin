class CountPerJobModel {
  String? jobName;
  int? count;

  CountPerJobModel({this.jobName, this.count});

  CountPerJobModel.fromJson(Map<String, dynamic> json) {
    jobName = json['jobName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobName'] = this.jobName;
    data['count'] = this.count;
    return data;
  }
}
