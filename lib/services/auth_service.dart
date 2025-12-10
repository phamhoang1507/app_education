import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/model/user.dart';
import 'package:education_app/utilities/formart_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;

  Future<bool> signInEmail(String email, String password) async {
    try {
      return (await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).user !=
          null;
    } catch (e) {
      print('signInWithEmai; error: $e');
      rethrow;
    }
  }

  Future<bool> signInGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await _createOrUpdateUserDocument(user);
      }

      return user != null;
    } catch (e) {
      print('signInWithGoogle error: $e');
      rethrow;
    }
  }

  Future<bool> signInFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) return false;

      final credential = FacebookAuthProvider.credential(
        result.accessToken!.tokenString,
      );

      return (await _auth.signInWithCredential(credential)).user != null;
    } catch (e) {
      print('signInWithFacebook error: $e');
      rethrow;
    }
  }

  Future<void> signInPhone(
    String phone, {
    required Function(String verificationId) codeSent,
    required Function(PhoneAuthCredential credential) completed,
    required Function(String error) failed,
    String? countryCode,
  }) async {
    String formattedPhone = formatToE164(phone, countryCode: countryCode);
    await _auth.verifyPhoneNumber(
      phoneNumber: formattedPhone,
      verificationCompleted: (c) async => completed(c),
      verificationFailed: (e) => failed(e.message ?? 'Gửi OTP thất bại'),
      codeSent: (id, _) => codeSent(id),
      codeAutoRetrievalTimeout: (id) {
        print('OTP timeout: $id');
      },
    );
  }

  Future<bool> verifyOTP(String id, String code) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: id,
        smsCode: code,
      );
      final result = await _auth.signInWithCredential(credential);
      return result.user != null;
    } catch (e) {
      print('Verify OTP error: $e');
      rethrow;
    }
  }

  Future<void> _createOrUpdateUserDocument(User user) async {
    DocumentReference userRef = _firestore.collection('users').doc(user.uid);

    DocumentSnapshot doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      await userRef.update({'lastLogin': FieldValue.serverTimestamp()});
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      if (!doc.exists) return null;
      final data = doc.data() as Map<String, dynamic>;

      return UserModel.fromJson(data);
    } catch (e) {
      print("getUser error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
