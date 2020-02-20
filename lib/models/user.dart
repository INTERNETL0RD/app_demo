class User {
  User(
      {this.date,
      this.picUrl,
      this.bkdPicUrl,
      this.id,
      this.fullName,
      this.email,
      this.userRole});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        date = data['date'],
        picUrl = data['picUrl'],
        bkdPicUrl = data['bkdPicUrl'];

  final String email;
  final String fullName;
  final String id;
  String userRole;
  String date;
  String picUrl;
  String bkdPicUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'date': date,
      'picUrl': picUrl,
      'bkdPicUrl': bkdPicUrl
    };
  }
}
