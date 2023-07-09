import 'package:amazon_app/common/widgets/custom%20button.dart';
import 'package:amazon_app/common/widgets/custom_textfield.dart';
import 'package:amazon_app/constants/global%20variable.dart';
import 'package:amazon_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum auth {
  signin,
  signup,
}

class authscreen extends StatefulWidget {
  static const String route = '/auth screen';
  const authscreen({super.key});

  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  auth selectedAuth = auth.signup;
  final signupformkey = GlobalKey<FormState>();
  final signinformkey = GlobalKey<FormState>();
  final authservice auth1 = authservice();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }

  void signupuser() {
    auth1.signupuser(
      context: context,
      email: emailcontroller.text,
      password: passwordcontroller.text,
      name: namecontroller.text,
    );
  }

  void signinuser() {
    auth1.signinuser(
      context: context,
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalvariable.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "WELCOME",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                tileColor: selectedAuth == auth.signup
                    ? globalvariable.backgroundColor
                    : globalvariable.greyBackgroundCOlor,
                title: Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: globalvariable.secondaryColor,
                  value: auth.signup,
                  groupValue: selectedAuth,
                  onChanged: (auth? val) {
                    setState(() {
                      selectedAuth = val!;
                    });
                  },
                ),
              ),
              if (selectedAuth == auth.signup)
                Container(
                  padding: EdgeInsets.all(8),
                  color: globalvariable.backgroundColor,
                  child: Form(
                    key: signupformkey,
                    child: Column(
                      children: [
                        customtextfield(
                          textEditingController: namecontroller,
                          hinttext: "Name",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customtextfield(
                          textEditingController: emailcontroller,
                          hinttext: "Email",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customtextfield(
                          textEditingController: passwordcontroller,
                          hinttext: "Password",
                          ispassword: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        custombutton(
                            text: "Sign Up",
                            ontap: () {
                              if (signupformkey.currentState!.validate()) {
                                signupuser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: selectedAuth == auth.signin
                    ? globalvariable.backgroundColor
                    : globalvariable.greyBackgroundCOlor,
                title: Text(
                  "Sign-In.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: globalvariable.secondaryColor,
                  value: auth.signin,
                  groupValue: selectedAuth,
                  onChanged: (auth? val) {
                    setState(() {
                      selectedAuth = val!;
                    });
                  },
                ),
              ),
              if (selectedAuth == auth.signin)
                Container(
                  padding: EdgeInsets.all(8),
                  color: globalvariable.backgroundColor,
                  child: Form(
                    key: signinformkey,
                    child: Column(
                      children: [
                        customtextfield(
                          textEditingController: emailcontroller,
                          hinttext: "Email",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customtextfield(
                          textEditingController: passwordcontroller,
                          hinttext: "Password",
                          ispassword: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        custombutton(
                          text: "Sign In",
                          ontap: () {
                            if (signinformkey.currentState!.validate()) {
                              signinuser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
