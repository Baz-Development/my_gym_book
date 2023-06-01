class UserModel {
  String fullname;
  String email;
  String imagePath;

  UserModel(this.fullname, this.email, this.imagePath);

  UserModel.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        email = json['email'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
    'fullname': fullname,
    'email': email,
    'imagePath': imagePath,
  };
}

class UserCheckModel extends UserModel {
  bool isMember;

  UserCheckModel(String fullname, String email, String imagePath, this.isMember)
      : super(fullname, email, imagePath);

  UserCheckModel.fromJson(Map<String, dynamic> json)
      : isMember = json['isMember'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['isMember'] = isMember;
    return data;
  }
}
