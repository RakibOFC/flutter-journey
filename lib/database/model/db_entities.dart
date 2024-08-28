class User {
  int? id;
  String name;
  String username;
  String password;
  String phone;

  User({
    this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
      phone: map['phone'],
    );
  }
}
