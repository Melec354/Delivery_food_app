class SignUpBody {
  String? name;
  String? phone;
  String? email;
  String? password;
  SignUpBody(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    name = json['f_name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}
