import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taskit/controller/RegisterController.dart';
import 'package:taskit/helper/FbAuthHelper.dart';
import 'package:taskit/views/screen/LoginPage.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registeration',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create a free account',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 33,
                      ),
                    ),
                    TextSpan(
                      text: '\nto get started',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Form(
                key: formKey,
                child: Consumer<RegistrationController>(
                    builder: (context, pro, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {},
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xE7EBEBF1),
                            hintText: 'Enter You Email',
                            hintStyle: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Password',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }

                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password must contain at least one uppercase letter';
                            }

                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return 'Password must contain at least one lowercase letter';
                            }

                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Password must contain at least one digit';
                            }

                            if (!value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return 'Password must contain at least one special character';
                            }

                            return null;
                          },
                          obscureText: pro.isPasswordVisible,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {},
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xE7EBEBF1),
                            suffixIcon: IconButton(
                              icon: pro.isPasswordVisible
                                  ? Icon(
                                      CupertinoIcons.eye,
                                    )
                                  : Icon(CupertinoIcons.eye_slash),
                              onPressed: () {
                                pro.togglePasswordVisibility();
                              },
                            ),
                            hintText: 'Enter Your Password',
                            hintStyle: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: TextFormField(
                          controller: confirmpasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your confirm password';
                            }

                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          obscureText: pro.isconfirmPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {},
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xE7EBEBF1),
                            suffixIcon: IconButton(
                              icon: pro.isconfirmPasswordVisible
                                  ? Icon(
                                      CupertinoIcons.eye,
                                    )
                                  : Icon(CupertinoIcons.eye_slash),
                              onPressed: () {
                                pro.toggleconfirmPasswordVisibility();
                              },
                            ),
                            hintText: 'Enter Your Confirm Password',
                            hintStyle: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await FBAuthHelper.fbAuthHelper
                        .registerWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: LoginPage(),
                        ));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff0f1933),
                  ),
                  child: Text('Register',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                child: Text(
                  'Or',
                  style: GoogleFonts.openSans(
                      fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Consumer<RegistrationController>(builder: (context, pro, child) {
                return Listener(
                  onPointerUp: (_) => {
                    pro.changeInside(false),
                  },
                  onPointerMove: (_) {
                    pro.changeInside(true);
                  },
                  child: GestureDetector(
                    onTap: () async {
                      await FBAuthHelper.fbAuthHelper.signInWithGoogle();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pro.isInside
                            ? Color(0xE7EBEBF1)
                            : Colors.grey.shade300,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                            height: 40,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            'Sign In with Google',
                            style: GoogleFonts.openSans(
                              color: pro.isInside ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: size.height * 0.08,
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account?',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: ' Login',
                        style: GoogleFonts.poppins(
                          color: Color(0xff0f1933),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: RegisterPage(),
                              ),
                            );
                          },
                      ),
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
