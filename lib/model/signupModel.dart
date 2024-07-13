class SignupModel {
  String? fullName;
  String? address;
  String? contact;
  String? password;
  String? id;

  SignupModel(
      {this.fullName, this.address, this.contact, this.password, this.id});

  SignupModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_Name'];
    address = json['address'];
    contact = json['contact'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_Name'] = this.fullName;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}
