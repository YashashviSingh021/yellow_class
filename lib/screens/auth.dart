import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/screens/todo_list_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  
  }

  Future<FirebaseUser> signInWithGoogle() async {
  // model.state =ViewState.Busy;
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;
  AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  AuthResult authResult = await _auth.signInWithCredential(credential);
  var _user = authResult.user;
  assert(!_user.isAnonymous);
  assert(await _user.getIdToken() != null);
  FirebaseUser currentUser = await _auth.currentUser();
  assert(_user.uid == currentUser.uid);
  // model.state =ViewState.Idle;
  print("User Name: ${_user.displayName}");
  print("User Email ${_user.email}");
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: 
        InkWell(
                    child: Container(
                        width:300,
                        height: 80,
                        margin: EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:Colors.white
                        ),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                        AssetImage('assets/download.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text('Sign in with Google',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            )
                        )
                    ),
                    onTap: ()
                    async{
                   signInWithGoogle()
                          .then((FirebaseUser user){
                        Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => TodoListScreeen(
                          
                        )));
                       }
                        ).catchError((e) => print(e));
                      },
                  ),),
      )
    );
  }
}
