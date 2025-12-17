import 'package:education_app/services/auth_service.dart';
import 'package:education_app/widgets/filed_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _keyEmail = GlobalKey<FormFieldState>();
  final _keyPhone = GlobalKey<FormFieldState>();
  final _keyPassword = GlobalKey<FormFieldState>();
  final _controllerEmail = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerPassword = TextEditingController();
  late bool _isLogEmail = true;
  bool _rememberMe = false;
  final _auth = AuthServices();
  String? _loginError;

  Future<void> _handleGoogle() async {
    final ok = await _auth.signInGoogle();
    if (ok) {
      context.go('/home');
    }
  }

  Future<void> _handlePhone() async {
    context.go('/home');
  }

  Future<void> _handleEmailPassword() async {
    String email = _controllerEmail.text.trim();
    String password = _controllerPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập đầy đủ email và password!')),
      );
      return;
    }

    try {
      final ok = await _auth.signInEmail(email, password);
      if (ok && mounted) {
        _loginError = null;
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential" ||
          e.code == "user-not-found" ||
          e.code == "wrong-password") {
        setState(() {
          _loginError = "Email hoặc mật khẩu không đúng";
        });
        _formKey.currentState?.validate();
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _isLogEmail
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FiledText(
                                    controller: _controllerEmail,
                                    hintText: 'Input email',
                                    textTitle: 'Email',
                                    keyForm: _keyEmail,
                                    hiddenText: false,
                                    leadIcon: Icons.email_outlined,
                                    validator: (value) {
                                      final bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                      ).hasMatch(value);
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if(emailValid != true) {
                                        return 'Please enter a valid email';
                                      }
                                      if (_loginError != null)
                                        return _loginError;
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  FiledText(
                                    hiddenText: true,
                                    controller: _controllerPassword,
                                    leadIcon: Icons.lock_outlined,
                                    lastIcon: [
                                      Icons.visibility_outlined,
                                      Icons.visibility_off_outlined,
                                    ],
                                    hintText: 'Input password',
                                    textTitle: 'Password',
                                    keyForm: _keyPassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      } else if (value.length < 8) {
                                        return 'Please enter a valid password';
                                      }
                                      if (_loginError != null)
                                        return _loginError;
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity:
                                                VisualDensity.compact,
                                            value: _rememberMe,
                                            activeColor: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _rememberMe = value ?? false;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Remember me',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.go('/forget');
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : FiledText(
                                controller: _controllerPhone,
                                hintText: '+84',
                                textTitle: 'Phone Number',
                                keyForm: _keyPhone,
                                hiddenText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  String phone = value.replaceAll(' ', '');

                                  if (phone.length < 10 || phone.length > 11) {
                                    return 'Số điện thoại phải từ 10-11 số';
                                  }

                                  if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                                    return 'Số điện thoại chỉ được chứa chữ số';
                                  }

                                  if (!phone.startsWith('0')) {
                                    return 'Số điện thoại phải bắt đầu bằng 0';
                                  }

                                  if (!RegExp(r'^0[0-9]{9}$').hasMatch(phone)) {
                                    return 'Số điện thoại không hợp lệ';
                                  }

                                  return null;
                                },
                              ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('9649ED'),
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() => _loginError = null);
                            if (_formKey.currentState?.validate() == true) {
                              _isLogEmail
                                  ? _handleEmailPassword()
                                  : _handlePhone();
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_isLogEmail) {
                              setState(() => _isLogEmail = !_isLogEmail);
                            } else {
                              setState(() => _isLogEmail = !_isLogEmail);
                            }
                          },
                          child: Text(
                            _isLogEmail
                                ? 'Login with Phone Number'
                                : 'Login with Email',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor('9649ED'),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/register');
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                      Text('OR'),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(width, 50),
                    ),
                    onPressed: () {
                      _handleGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/google.svg'),
                        SizedBox(width: 10),
                        Text('Continue with Google'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/facebook.svg'),
                        SizedBox(width: 10),
                        Text('Continue with Facebook'),
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
