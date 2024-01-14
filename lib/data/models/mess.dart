
class DayMenu{
DayMenu({
  required this.breakfast,

  required this.lunch,

  required this.supper,

  required this.dinner,

});
String breakfast;
String lunch;
String supper;
String dinner;
 Map<String, dynamic> toJson() => {
    "breakfast": breakfast,
    "lunch": lunch,
    "supper": supper,
    "dinner": dinner,
  };
  DayMenu.fromJson(Map<String, dynamic> json)
      : breakfast = json['breakfast'],
        lunch = json['lunch'],
        supper = json['supper'],
        dinner = json['dinner'];
}

enum Days{
  monday,tuesday,wednesday,thursday,friday,saturday,sunday
}

class Mess
{
  Mess({
    required this.title,
    required this.menu,
    required this.number,
    required this.occupied,
    required this.vegnonveg,
    required this.perdaycost
  });
 
  String title;
  int occupied;
  int number;
  String vegnonveg;
  Map<Days,DayMenu> menu;
  int perdaycost;
    Map<String, dynamic> toJson() => {
    "title": title,
    "occupied": occupied,
    "number": number,
    "vegnonveg": vegnonveg,
    "perdaycost": perdaycost,
    "menu": menu.map((key, value) => MapEntry(key.toString(), value.toJson())), // Convert DayMenu objects to Maps
  };
  Mess.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        menu = (json['Menu'] as Map<String, dynamic>).map((key, value) => MapEntry(Days.values.byName(key), DayMenu.fromJson(value))),
        number = json['Totalnumber'],
        occupied = json['occupants'],
        vegnonveg = json['vegnonveg'],
        perdaycost = json['perdaycost'];
}