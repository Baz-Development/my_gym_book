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
