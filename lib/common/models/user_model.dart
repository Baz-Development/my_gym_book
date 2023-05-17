class UserModel {
  String userId;
  String fullname;
  String email;

  UserModel(
      this.fullname,
      this.email,
      this.userId
  );

  UserModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        fullname = json['fullname'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'fullname': fullname,
    'email': email
  };
}