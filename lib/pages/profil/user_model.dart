class UserModel {
  String name = "";
  int id = 0;
  int makenum = 0;
  List<int> friendid = [];
  List<int> recipeid = [];
  List<int> recentrecipeid = [];

  UserModel(
      {required name,
      required id,
      required makenum,
      required friendid,
      required recipeid});
}
