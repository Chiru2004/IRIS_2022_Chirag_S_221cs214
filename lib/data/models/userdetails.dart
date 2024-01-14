class userdetails {
  Date? date;
  String? email;
  String? mess;
  int? messbalance;
  String? name;
  String? password;
  String? rollnumber;

  userdetails(
      {this.date,
      this.email,
      this.mess,
      this.messbalance,
      this.name,
      this.password,
      this.rollnumber});

  userdetails.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    email = json['email'];
    mess = json['mess'];
    messbalance = json['messbalance'];
    name = json['name'];
    password = json['password'];
    rollnumber = json['rollnumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    data['email'] = this.email;
    data['mess'] = this.mess;
    data['messbalance'] = this.messbalance;
    data['name'] = this.name;
    data['password'] = this.password;
    data['rollnumber'] = this.rollnumber;
    return data;
  }
}

class Date {
  String? starting;
  String? ending;

  Date({this.starting, this.ending});

  Date.fromJson(Map<String, dynamic> json) {
    starting = json['Starting'];
    ending = json['ending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Starting'] = this.starting;
    data['ending'] = this.ending;
    return data;
  }
}
