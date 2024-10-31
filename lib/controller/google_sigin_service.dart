import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  
  // Instances
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
 
 // Function for google sign-in
  googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      
      // Check the condition for google sign account whether null or not
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = 
        await googleSignInAccount.authentication;

        // Google provide authorized credential for authorized user
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
          await _auth.signInWithCredential(authCredential);
        print(_auth.currentUser!.uid); 
      }
    }
    on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  // Function for google sign-out and disconnect the google account
  googleLogout() async {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}