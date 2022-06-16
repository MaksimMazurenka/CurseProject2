
import 'package:flutter/material.dart';
import 'package:helper_app/Screens/home_page.dart';
import 'package:helper_app/data/file_handler.dart';
import 'package:helper_app/entity/user.dart';

class getEmail{
  String userEmail = "";
  dynamic setUserEmail(String email){
    userEmail = email;
  }
  String getUserEmail(){
    return userEmail;
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  TextEditingController emailID = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    emailID.dispose();
    password.dispose();
    super.dispose();
  }

  void getUsersData(String email, String password) async{
    Future<List<User>> _users = FileHandler.instance.readUsers();
    List<User> userrs = await _users;
    for(int i = 0; i<userrs.length;i++){
      if(userrs[i].email==email && userrs[i].phone==password){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(emailr: email)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextField("emailID", emailID, Icons.person, false),
            SizedBox(height: 15),
            buildTextField("Password", password, Icons.lock, true),
            SizedBox(height: 15),
            buildSubmitBtn(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText,
      TextEditingController textEditingController,
      IconData prefixIcons,
      bool isPassword) =>
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextFormField(
          obscureText: isPassword,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5.5),
            ),
            prefixIcon: Icon(prefixIcons, color: Colors.blue),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.blue),
            filled: true,
            fillColor: Colors.blue[50],
          ),
        ),
      );

  Widget buildSubmitBtn() => ElevatedButton(
      onPressed: () {
        getUsersData(emailID.text, password.text);
      },
      child: const Text("Login"));
}
