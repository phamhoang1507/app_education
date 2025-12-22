import 'package:education_app/model/user.dart';
import 'package:education_app/services/auth_service.dart';
import 'package:education_app/utilities/common_variables.dart';
import 'package:education_app/utilities/flutter_toast.dart';
import 'package:education_app/utilities/exception_firebase.dart';
import 'package:education_app/utilities/input_confirm.dart';
import 'package:education_app/widgets/custombar.dart';
import 'package:education_app/widgets/icon_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthServices();
    final user = FirebaseAuth.instance.currentUser!;
    final myUser = auth.getUser(user.uid);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
          onPressed: () => context.pop(),
        ),
        leadingWidth: 40,
        titleSpacing: 0,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [HexColor('#7623D0'), HexColor('#D5BAF8')],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 7, child: Scaffold()),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: SingleChildScrollView(
                child: FutureBuilder<UserModel?>(
                  future: myUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: commonBarPadding,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text("Không tải được user"));
                    }
                    final data = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          padding: commonPadding,
                          width: double.infinity,
                          height: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage: data.photoURL != null
                                    ? NetworkImage(data.photoURL!)
                                    : null,
                                child: data.photoURL == null
                                    ? Icon(
                                        Icons.account_circle_sharp,
                                        size: 75,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.displayName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    data.email,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    data.phoneNumber ?? "Không số điện thoại",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              // SizedBox(width: 15),
                              // InkWell(
                              //   onTap: (){
                              //     print('edit');
                              //   },
                              //   child: Icon(Icons.edit)
                              // )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Custombar(
                                leading: Text('User ID'),
                                late: Text(
                                  data.uid,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Custombar(
                                leading: Text('Department'),
                                isLast: true,
                                late: Text(
                                  'Programer',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Custombar(
                                onTap: () {
                                  print(123);
                                },
                                leading: IconText(
                                  text: 'Personal Information',
                                  icon: Icons.person_outline_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                              Custombar(
                                onTap: () {
                                  print(123);
                                },
                                leading: IconText(
                                  text: 'Payment',
                                  icon: Icons.payment_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                              Custombar(
                                onTap: () {
                                  print(123);
                                },
                                leading: IconText(
                                  text: 'Support',
                                  icon: Icons.headset_mic_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                              Custombar(
                                onTap: () {
                                  print(123);
                                },
                                isLast: true,
                                leading: IconText(
                                  text: 'Login & Security',
                                  icon: Icons.shield_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Custombar(
                                onTap: () {
                                  context.push('/terms');
                                },
                                leading: IconText(
                                  text: 'Terms & conditions',
                                  icon: Icons.description_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                              Custombar(
                                onTap: () {
                                  context.push('/policy');
                                },
                                isLast: true,
                                leading: IconText(
                                  text: 'Privacy Policy',
                                  icon: Icons.description_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Custombar(
                                onTap: () {
                                  _toggleDeleteAccount(context, auth);
                                },
                                leading: IconText(
                                  text: 'Delete Account',
                                  icon: Icons.person_remove_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                              ),
                              Custombar(
                                onTap: () {
                                  auth.signOut();
                                  context.go('/login');
                                },
                                isLast: true,
                                leading: IconText(
                                  text: 'Logout',
                                  icon: Icons.logout_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleDeleteAccount(
    BuildContext context,
    AuthServices auth,
  ) async {
    final user = auth.currentUser;

    if (user == null) {
      showToast(context, 'Không có người dùng');
      context.go('/login');
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận xóa tài khoản'),
        content: Text(
          'Tài khoản của bạn sẽ bị xóa vĩnh viễn và không thể khôi phục.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    String? password;

    if (user.providerData.first.providerId == "password") {
      password = await inputConfirm(
        context,
        'Xác nhận mật khẩu',
        'Nhập mật khẩu',
      );
      if (password == null) {
        return;
      }
      if (password.isEmpty) {
        showToast(context, "Bạn chưa nhập password");
        return;
      }
    }

    if (user.providerData.first.providerId == "google.com") {
      password = await inputConfirm(context, 'Xác nhận email', 'Nhập email');
      if (password == null || password.isEmpty) {
        showToast(context, "Bạn chưa nhập email");
        return;
      }
    }

    // Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await auth.deleteUserAccount(emailPassword: password);
      if (context.mounted) {
        Navigator.pop(context);

        context.go('/login');
        showToast(context, "Xóa tài khoản thành công");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      final errorMessage = ExceptionFirebase.getErrorFirebase(e);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      print('Firebase Auth Error: ${e.code} - ${e.message}');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lỗi kết nối. Vui lòng kiểm tra mạng.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<String?> showPasswordInput(BuildContext context) async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xác nhận mật khẩu"),
          content: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(labelText: "Nhập mật khẩu"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: Text("Tiếp tục"),
            ),
          ],
        );
      },
    );
  }
}
