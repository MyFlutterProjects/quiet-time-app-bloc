import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qt_bloc_app/blocs/auth_bloc.dart';
import 'package:qt_bloc_app/blocs/user_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  AuthBloc _authBloc;

  @override 
  void initState() {
    _authBloc = AuthBloc();
  }

  double screenHeight;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // StreamSubscription blocSubscription;


  void authenticate() {
    _authBloc.authenticate(_usernameController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;// get screen size
    return Scaffold(
      body: 
      
      SingleChildScrollView( 
        child: Stack( 
          children: <Widget>[
            lowerHalf(context),
            upperHalf(context),
            loginCard(context),
          ],
          ),
      ),   
    );
  }

  Widget upperHalf(BuildContext context) { 
     var screenSize = MediaQuery.of(context).size;
     print(screenSize);

    return Container( 
      height: screenHeight /2,
      width: screenSize.width, // fill up screen width
      child: Image.asset(
        // 'images/coffee_bible.jpg',
        "images/reading-bible.jpg",
         fit: BoxFit.cover,  // fit image in box     
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align( 
      alignment: Alignment.bottomCenter,
      child: Container( 
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
        // color: Colors.blue,
      ),
    );
  }
  
  Widget loginCard(BuildContext context) {
    return Column( 
      children: <Widget>[
        Container( 
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 1, right: 10),
          child: Card( 
            shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8, 
            child: Padding( 
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Align( 
                    alignment: Alignment.topLeft,
                    child: Text( 
                      "Login",
                      style: TextStyle( 
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox( height: 15,),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration( 
                      labelText: "Your username",
                      hasFloatingPlaceholder: true
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField( 
                    controller: _passwordController,
                    decoration: InputDecoration( 
                      labelText: "Password",
                      hasFloatingPlaceholder: true)
                  ),
                  SizedBox( height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton( 
                        onPressed: (){},
                        child: Text("Forgot Password ?"),
                      ),
                      Expanded( 
                        child: Container(),
                      ),
                      FlatButton( 
                        child: Text("Login"),
                        color: Color(0xFF4B9DFE),
                        textColor: Colors.white,
                        padding: EdgeInsets.only( 
                          left: 38, right: 38, top: 15, bottom: 15
                        ),
                        shape: RoundedRectangleBorder( 
                          borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: () { 
                          authenticate();
                        },
                      )

                  ],
                  )
                ]
              ),
            ),

          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text( 
              "Already have an account",
              style: TextStyle( color: Colors.grey),
            ),
            FlatButton( 
              onPressed: () {
              setState(() {
                // _authMode = AuthMode.LOGIN;
              });
           },
         textColor: Colors.black87,
         child: Text("Login"),
            ),
        ],
        ),

        Align( 
          alignment: Alignment.bottomCenter, 
          child: FlatButton( 
            child: Text("Terms and conditions",
            style: TextStyle( 
              color:Colors.grey,
            ),
            ),
            onPressed: () {},
          ),
        )
        


      ],
      );
  }

}