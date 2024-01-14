class requestdata {
  String? studentname;
  String? studentroll;
  String? changedmessid;
  String? changedmessname;
  String? currentmessid;
  String? currentmessname;
  String? state;
  String? studentid;
  String? studentkey;
  int? currentmessoccupants;
  int? changemessoccupants;

  requestdata(
      {this.studentname,
      this.studentroll,
      this.changedmessid,
      this.changedmessname,
      this.currentmessid,
      this.currentmessname,
      this.state,
      this.studentid,
      this.studentkey,
      this.currentmessoccupants,
      this.changemessoccupants});

  requestdata.fromJson(Map<String, dynamic> json) {
    studentname = json['Studentname'];
    studentroll = json['Studentroll'];
    changedmessid = json['changedmessid'];
    changedmessname = json['changedmessname'];
    currentmessid = json['currentmessid'];
    currentmessname = json['currentmessname'];
    state = json['state'];
    studentid = json['studentid'];
    studentkey = json['studentkey'];
    currentmessoccupants = json['currentmessoccupants'];
    changemessoccupants = json['changemessoccupants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Studentname'] = this.studentname;
    data['Studentroll'] = this.studentroll;
    data['changedmessid'] = this.changedmessid;
    data['changedmessname'] = this.changedmessname;
    data['currentmessid'] = this.currentmessid;
    data['currentmessname'] = this.currentmessname;
    data['state'] = this.state;
    data['studentid'] = this.studentid;
    data['studentkey'] = this.studentkey;
    data['currentmessoccupants'] = this.currentmessoccupants;
    data['changemessoccupants'] = this.changemessoccupants;
    return data;
  }
}
