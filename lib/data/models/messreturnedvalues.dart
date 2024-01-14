class messvalues {
  Menu? menu;
  int? totalnumber;
  int? occupants;
  int? perdaycost;
  String? title;
  String? vegnonveg;

  messvalues(
      {this.menu,
      this.totalnumber,
      this.occupants,
      this.perdaycost,
      this.title,
      this.vegnonveg});

  messvalues.fromJson(Map<String, dynamic> json) {
    menu = json['Menu'] != null ? new Menu.fromJson(json['Menu']) : null;
    totalnumber = json['Totalnumber'];
    occupants = json['occupants'];
    perdaycost = json['perdaycost'];
    title = json['title'];
    vegnonveg = json['vegnonveg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menu != null) {
      data['Menu'] = this.menu!.toJson();
    }
    data['Totalnumber'] = this.totalnumber;
    data['occupants'] = this.occupants;
    data['perdaycost'] = this.perdaycost;
    data['title'] = this.title;
    data['vegnonveg'] = this.vegnonveg;
    return data;
  }
}

class Menu {
  Friday? friday;
  Friday? monday;
  Friday? saturday;
  Friday? sunday;
  Friday? thursday;
  Friday? tuesday;
  Friday? wednesday;

  Menu(
      {this.friday,
      this.monday,
      this.saturday,
      this.sunday,
      this.thursday,
      this.tuesday,
      this.wednesday});

  Menu.fromJson(Map<String, dynamic> json) {
    friday =
        json['friday'] != null ? new Friday.fromJson(json['friday']) : null;
    monday =
        json['monday'] != null ? new Friday.fromJson(json['monday']) : null;
    saturday =
        json['saturday'] != null ? new Friday.fromJson(json['saturday']) : null;
    sunday =
        json['sunday'] != null ? new Friday.fromJson(json['sunday']) : null;
    thursday =
        json['thursday'] != null ? new Friday.fromJson(json['thursday']) : null;
    tuesday =
        json['tuesday'] != null ? new Friday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Friday.fromJson(json['wednesday'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    return data;
  }
}

class Friday {
  String? breakfast;
  String? dinner;
  String? lunch;
  String? supper;

  Friday({this.breakfast, this.dinner, this.lunch, this.supper});

  Friday.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'];
    dinner = json['dinner'];
    lunch = json['lunch'];
    supper = json['supper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breakfast'] = this.breakfast;
    data['dinner'] = this.dinner;
    data['lunch'] = this.lunch;
    data['supper'] = this.supper;
    return data;
  }
}
