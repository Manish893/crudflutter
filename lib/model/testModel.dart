class TestModel {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? gender;
  String? email;
  String? password;
  String? profilePic;
  String? panNo;
  String? registrationNo;
  String? role;
  String? firebaseToken;

  TestModel(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.gender,
      this.email,
      this.password,
      this.profilePic,
      this.panNo,
      this.registrationNo,
      this.role,
      this.firebaseToken});

  TestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    email = json['email'];
    password = json['password'];
    profilePic = json['profilePic'];
    panNo = json['panNo'];
    registrationNo = json['registrationNo'];
    role = json['role'];
    firebaseToken = json['firebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['password'] = this.password;
    data['profilePic'] = this.profilePic;
    data['panNo'] = this.panNo;
    data['registrationNo'] = this.registrationNo;
    data['role'] = this.role;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}
