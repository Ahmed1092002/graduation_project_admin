class AdminModel {
  int? adminId;
  int? userId;
  String? roles;
  int? permission;
  String? userName;
  String? qualification;

  AdminModel(
      {this.adminId, this.userId, this.roles, this.permission, this.userName, this.qualification});

  AdminModel.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    userId = json['userId'];
    roles = json['roles'];
    permission = json['permission'];
    userName = json['userName'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['userId'] = this.userId;
    data['roles'] = this.roles;
    data['permission'] = this.permission;
    data['userName'] = this.userName;
    data['qualification'] = this.qualification;
    return data;
  }
}
