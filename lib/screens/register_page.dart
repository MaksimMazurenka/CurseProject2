
import 'package:flutter/material.dart';
import 'package:helper_app/data/file_handler.dart';
import 'package:helper_app/entity/user.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailID = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    emailID.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register page"),
      ),
      body: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
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

  Widget buildTextField(String labelText,
      TextEditingController textEditingController,
      IconData prefixIcons,
      bool isPassword) =>
      SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.5,
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

  Widget buildSubmitBtn() =>
      ElevatedButton(
          onPressed: () {
            Address addred = Address(
                houseNo: "dom", locality: "eto", city: "some", state: "aga");
            User user = User(id: 1,
                email: emailID.text,
                name: "userAddress: null",
                phone: password.text,
                userAddress: addred);
            FileHandler.instance.writeUser(user);
            // Authentication().signUp(emailID.text, password.text);
          },
          child: const Text("Register"));
}