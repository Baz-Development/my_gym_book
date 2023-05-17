class UserModel {
  String fullname;
  String email;

  UserModel(
      this.fullname,
      this.email
  );

  UserModel.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'fullname': fullname,
    'email': email
  };
}