import 'dart:developer';

import 'package:easacc_task/core/errors/exceptions.dart';
import 'package:easacc_task/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:easacc_task/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<String> loginByGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw ServerException(LocaleKeys.googleSignInCanceled.tr());
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return LocaleKeys.loginWithGoogleSuccess.tr();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginByFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        throw ServerException(LocaleKeys.facebookLoginCanceledOrFailed.tr());
      }

      final AccessToken accessToken = result.accessToken!;
      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.tokenString,
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      log(userCredential.additionalUserInfo!.username.toString());
      log(userCredential.user!.email.toString());
      return LocaleKeys.loginWithFacebookSuccess.tr();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
