import 'package:education_app/widgets/filed_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyEmail = GlobalKey<FormState>();
  final _keyPassword = GlobalKey<FormState>();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(title: const Text('abc')),
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
                    child: Column(
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (value.contains('@') == false) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        FiledText(
                          hiddenText: true,
                          controller: _controllerPassword,
                          leadIcon: Icons.lock_outlined,
                          lastIcon: [Icons.visibility_outlined,Icons.visibility_off_outlined], 
                          hintText: 'Input password', 
                          textTitle: 'Password', 
                          keyForm: _keyPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // bo góc
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity
                                      .compact, // giảm padding mặc định
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
                                // TODO: Chuyển sang trang quên mật khẩu
                                // context.go('/forgot-password');
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
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
                          onPressed: () {},
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Login with Phone Nummber'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ", // Phần text không bấm được
                      style: TextStyle(color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register', // Phần text muốn bấm được
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor('9649ED'),
                            decoration: TextDecoration.underline,
                          ),
                          // Thêm sự kiện onTap vào đây
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // 💡 Hành động khi bấm vào chữ 'Register'
                              // context.go('/register');
                              print('Chỉ bấm vào chữ Register');
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
                          color: Colors.grey, // Màu đường kẻ
                          thickness: 1, // Độ dày đường kẻ
                          indent: 10,
                          endIndent: 10, // Khoảng trống trước chữ "OR"
                        ),
                      ),
                      Text('OR'),
                      Expanded(
                        child: Divider(
                          color: Colors.grey, // Màu đường kẻ
                          thickness: 1, // Độ dày đường kẻ
                          indent: 10,
                          endIndent: 10, // Khoảng trống trước chữ "OR"
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
                    onPressed: () {},
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
