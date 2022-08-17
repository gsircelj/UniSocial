class User {
  String firstName;
  String lastName;
  String email;
  int day, month, year; // birthday
  String password;
  List<String> categories;

  User({this.firstName, this.lastName, this.email, this.day, this.month, this.year, this.password, this.categories});
}