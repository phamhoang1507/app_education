import 'package:education_app/extensions/l10n.dart';
import 'package:education_app/model/user.dart';
import 'package:education_app/routers/navigation_manager.dart';
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
    final l10n = context.l10n;
    final auth = AuthServices();
    final user = FirebaseAuth.instance.currentUser!;
    final myUser = auth.getUser(user.uid);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          l10n.profile,
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
                      return Center(child: Text(l10n.errorLoadUser));
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
                                    data.phoneNumber ?? l10n.noPhoneNumber,
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
                                leading: Text(l10n.userId),
                                late: Text(
                                  data.uid,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Custombar(
                                leading: Text(l10n.department),
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
                                  text: l10n.personalInformation,
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
                                  text: l10n.payment,
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
                                  text: l10n.support,
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
                                  text: l10n.loginSecurity,
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
                                  context.nav.toTerms(context);
                                },
                                leading: IconText(
                                  text: l10n.termsConditions,
                                  icon: Icons.description_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                                late: Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                              Custombar(
                                onTap: () {
                                  context.nav.toPolicy(context);
                                },
                                isLast: true,
                                leading: IconText(
                                  text: l10n.privacyPolicy,
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
                                  text: l10n.deleteAccount,
                                  icon: Icons.person_remove_outlined,
                                  color: Colors.black,
                                  sizeIcon: 25,
                                  fontSize: 14,
                                ),
                              ),
                              Custombar(
                                onTap: () {
                                  auth.signOut();
                                  context.nav.toLogin(context);
                                },
                                isLast: true,
                                leading: IconText(
                                  text: l10n.logout,
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
    final l10n = context.l10n;

    if (user == null) {
      showToast(context, l10n.noUser);
      context.nav.toLogin(context);
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmDeleteAccount),
        content: Text(
          l10n.deleteAccountWarning,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    String? password;

    if (user.providerData.first.providerId == "password") {
      password = await inputConfirm(
        context,
        l10n.confirmPassword,
        l10n.enterPassword,
      );
      if (password == null) {
        return;
      }
      if (password.isEmpty) {
        showToast(context, l10n.errorMissingPassword);
        return;
      }
    }

    if (user.providerData.first.providerId == "google.com") {
      password = await inputConfirm(context, l10n.confirmEmail, l10n.inputEmail);
      if (password == null || password.isEmpty) {
        showToast(context, l10n.errorMissingPassword);
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

        context.nav.toLogin(context);
        showToast(context, l10n.deleteAccountSuccess);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      final errorMessage = ExceptionFirebase.getErrorFirebase(e, context);

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
          SnackBar(
            content: Text(l10n.errorConnection),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<String?> showPasswordInput(BuildContext context) async {
    final controller = TextEditingController();
    final l10n = context.l10n;

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.confirmPassword),
          content: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(labelText: l10n.enterPassword),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: Text(l10n.continueText),
            ),
          ],
        );
      },
    );
  }
}
