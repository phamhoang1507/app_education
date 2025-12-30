import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/routers/navigation_manager.dart';
import 'package:education_app/services/auth_service.dart';
import 'package:education_app/widgets/filed_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final l10n = context.l10n;

    try {
      final signUpOk = await _auth.signUpEmail(email, password, name);
      if (signUpOk) {
        final ok = await _auth.signInEmail(email, password);
        if (ok) {
          context.nav.toHome(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        setState(() {
          _loginError = l10n.errorInvalidEmailFormat;
        });
        _formKey.currentState?.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 40,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_sharp),
          color: Colors.black,
          onPressed: () => context.nav.pop(context),
        ),
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
                          hintText: l10n.inputName,
                          textTitle: l10n.name,
                          keyForm: _keyDisplayName,
                          hiddenText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterName;
                            }
                            // to do duplicate
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        FiledText(
                          leadIcon: Icons.email_outlined,
                          controller: _controllerEmail,
                          hintText: l10n.inputEmail,
                          textTitle: l10n.email,
                          keyForm: _keyEmail,
                          hiddenText: false,
                          validator: (value) {
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value);
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterEmail;
                            }
                            if (emailValid == false) {
                              return l10n.errorInvalidEmailFormat;
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
                          hintText: l10n.inputPassword,
                          textTitle: l10n.password,
                          keyForm: _keyPassword,
                          hiddenText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterPassword;
                            } else if (value.length < 8) {
                              return l10n.pleaseEnterValidPassword;
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
                          hintText: l10n.inputPassword,
                          textTitle: l10n.confirmPassword,
                          keyForm: _keyConfirmPassword,
                          hiddenText: false,
                          validator: (value) {
                            if (value != _controllerPassword.text) {
                              return l10n.passwordNotMatch;
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
                            l10n.signup,
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
