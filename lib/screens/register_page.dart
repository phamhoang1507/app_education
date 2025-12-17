import 'package:education_app/services/auth_service.dart';
import 'package:education_app/widgets/filed_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _keyDisplayName = GlobalKey<FormFieldState>();
  final _keyEmail = GlobalKey<FormFieldState>();
  final _keyPassword = GlobalKey<FormFieldState>();
  final _keyConfirmPassword = GlobalKey<FormFieldState>();
  final _controllerDisplayName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  final _auth = AuthServices();
  String? _loginError;

  Future<void> _handleSignup() async {
    String email = _controllerEmail.text.trim();
    String password = _controllerPassword.text.trim();
    String name = _controllerDisplayName.text.trim();
    try {
      final signUpOk = await _auth.signUpEmail(email, password, name);
      if (signUpOk) {
        final ok = await _auth.signInEmail(email, password);
        if (ok) {
          context.go('/home');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        setState(() {
          _loginError = "Email không đúng định dạng. Vui lòng kiểm tra lại!";
        });
        _formKey.currentState?.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: height * 0.15,
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FiledText(
                          leadIcon: Icons.person_outline,
                          controller: _controllerDisplayName,
                          hintText: 'Input Name',
                          textTitle: 'Name',
                          keyForm: _keyDisplayName,
                          hiddenText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            // to do duplicate
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        FiledText(
                          leadIcon: Icons.email_outlined,
                          controller: _controllerEmail,
                          hintText: 'Input Email',
                          textTitle: 'Email',
                          keyForm: _keyEmail,
                          hiddenText: false,
                          validator: (value) {
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value);
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (emailValid == false) {
                              return 'Please enter a valid email';
                            }
                            print(_loginError);
                            if (_loginError != null) return _loginError;
                            // to do duplicate
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        FiledText(
                          leadIcon: Icons.lock_outline,
                          lastIcon: [
                            Icons.visibility_outlined,
                            Icons.visibility_off_outlined,
                          ],
                          controller: _controllerPassword,
                          hintText: 'Input Password',
                          textTitle: 'Password',
                          keyForm: _keyPassword,
                          hiddenText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Please enter a valid password';
                            }
                            // to do duplicate
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        FiledText(
                          leadIcon: Icons.lock_outline,
                          lastIcon: [
                            Icons.visibility_outlined,
                            Icons.visibility_off_outlined,
                          ],
                          controller: _controllerConfirmPassword,
                          hintText: 'Input Password',
                          textTitle: 'Confirm Password',
                          keyForm: _keyConfirmPassword,
                          hiddenText: false,
                          validator: (value) {
                            if (value != _controllerPassword.text) {
                              return 'Password entered does not match.';
                            }
                            // to do duplicate
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            backgroundColor: HexColor('9649ED'),
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() => _loginError = null);
                            if (_formKey.currentState?.validate() == true) {
                              _handleSignup();
                            }
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
