import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/screens/Authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String? errorMessage = '';
  bool isLogin = true;
  bool _passwordVisible = false;
  bool isLoading = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  late final AnimationController _controllerAnimation;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;

    _controllerAnimation = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }

  bool loginAnimation = false;

  Future<void> signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (loginAnimation == false) {
        _controllerAnimation.forward();
        loginAnimation = true;
      } else {
        _controllerAnimation.reverse();
        loginAnimation = false;
      }
      try {
        await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        setState(() {
          isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = e.message;
        });
      }
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Auth().CreateUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        setState(() {
          isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = e.message;
        });
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> requestMultiplePermissions(BuildContext context) async {
    final permissions = [
      Permission.camera,
      Permission.microphone,
      // Add more permissions you need here
    ];

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    // Check the status of each requested permission
    statuses.forEach((permission, status) {
      if (status.isGranted) {
        // Permission granted
        print('${permission.toString()}: granted');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Granted'),
              content:
                  Text('${permission.toString()} permission has been granted.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (status.isDenied) {
        // Permission denied
        print('${permission.toString()}: denied');
      } else if (status.isPermanentlyDenied) {
        // Permission permanently denied, ask user to go to settings
        openAppSettings();
      }
    });
  }

  Widget _permissionButton() {
    return ElevatedButton(
      onPressed: () {
        requestMultiplePermissions(context); // Pass the context
      },
      child: Text('Request Permissions'),
    );
  }

  Widget _title() {
    return const Text('Helping Hands');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        } else if (title == 'Email' && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _passwordEntryField(
    TextEditingController controller,
  ) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        } else if (value.length < 8) {
          return 'Password should be at least 8 characters';
        }
        return null;
      },
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Error : $errorMessage');
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '684143871341-9dvnce6gk60jbpinsfbh9740ni2ur2m1.apps.googleusercontent.com',
  );

  Widget _submitButton() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isLogin
              ? signInWithEmailAndPassword
              : createUserWithEmailAndPassword,
          child: Text(isLogin ? 'Login' : 'Register'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: signInWithGoogle,
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Customize the button color
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/google_logo2.png', height: 24.0),
              const SizedBox(width: 12.0),
              const Text('Sign in with Google'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginOrRegistrationButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  Widget _animation() {
    return Lottie.asset(
      'assets/login.json',
      controller: _controllerAnimation,
      height: 200,
      reverse: true,
      repeat: true,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: _title(),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/vibrant-summer-ombre-background-vector_53876-105765.jpg?w=360'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () => {
                              if (loginAnimation == false)
                                {
                                  _controllerAnimation.forward(),
                                  loginAnimation = true
                                }
                              else
                                {
                                  _controllerAnimation.reverse(),
                                  loginAnimation = false
                                }
                            },
                            child: _animation(),
                          ),
                        ),
                        const SizedBox(height: 40),
                        _entryField('Email', _controllerEmail),
                        _passwordEntryField(_controllerPassword),
                        if (isLoading) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(),
                          ),
                        ],
                        _errorMessage(),
                        _submitButton(),
                        _loginOrRegistrationButton(),
                        // _permissionButton(),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
