import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  static String userLogedKey = "LOGGEDINKEY"; //BOOLEAN  key....(signup)
  static String userEmailKey = "EMAILINKEY";
//set SF
  static Future<bool> saveuserLoggedfun(bool userLoged) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setBool(userLogedKey, userLoged);
  } //=>check the user logged or Not(signin,logIn,Logout)

  static Future<bool> saveuserEmailfun(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey, userEmail);
  }

//get SF
  static Future<bool?> getUserLoggedIn() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLogedKey);
  } //=>splash Screen

  static Future<String?> getEmailLoggedIN() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
}
