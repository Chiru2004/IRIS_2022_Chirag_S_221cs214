

class UserIndividual{
UserIndividual(
{
required this.name,
required this.rollnumber,
required this.email,
required this.password, 
required this.userId

});
 String name;
 String rollnumber;
 String email;
 String password;
 String userId;

}

class UserIndividualfetchedAdmin{
  UserIndividualfetchedAdmin({
    required this.id,
    required this.rollnumber,
    required this.name
  });

  String id;
  String rollnumber;
  String name;

}


//class dedicated just to user the data fetched from the user
class fetchuserclass {
  String? name;
  String? roll;

  fetchuserclass({this.name, this.roll});

  fetchuserclass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roll = json['roll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['roll'] = this.roll;
    return data;
  }
}
