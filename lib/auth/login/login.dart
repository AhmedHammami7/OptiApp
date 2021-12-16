import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/auth/register/register.dart';
import 'package:social_media_app/components/password_text_field.dart';
import 'package:social_media_app/components/text_form_builder.dart';
import 'package:social_media_app/utils/validation.dart';
import 'package:social_media_app/view_models/auth/login_view_model.dart';
import 'package:social_media_app/widgets/indicators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    return ModalProgressHUD(
        progressIndicator: circularProgress(context),
        inAsyncCall: viewModel.loading,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            key: viewModel.scaffoldKey,
            body: Container(
              decoration: new BoxDecoration(
                  color: Color(0xffeeeeee),
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          new AssetImage('assets/images/backgroundLogin.png'))),
              child: new Center(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  children: [
                    SizedBox(height: 5.0),
                    Container(
                      height: 160.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    //SizedBox(height: 10.0),
                    //SizedBox(height: 25.0),
                    buildForm(context, viewModel),
                    SizedBox(height: 20.0),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                CupertinoPageRoute(builder: (_) => Register()));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            )));
  }

  buildForm(BuildContext context, LoginViewModel viewModel) {
    return Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(1.0),
          margin: EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            gradient: LinearGradient(
                colors: [
                  const Color(0xFFE9263A),
                  const Color(0xFFF38E47),
                ],
                begin: const FractionalOffset(0.0, 0.5),
                end: const FractionalOffset(1.25, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Image.asset('assets/images/logo-optima-blanc.png'),
              SizedBox(height: 25.0),
              TextFormBuilder(
                enabled: !viewModel.loading,
                prefix: Feather.mail,
                hintText: "E-mail",
                textInputAction: TextInputAction.next,
                validateFunction: Validations.validateEmail,
                onSaved: (String val) {
                  viewModel.setEmail(val);
                },
                focusNode: viewModel.emailFN,
                nextFocusNode: viewModel.passFN,
              ),
              SizedBox(height: 15.0),
              PasswordFormBuilder(
                enabled: !viewModel.loading,
                prefix: Feather.lock,
                suffix: Feather.eye,
                hintText: "Mot de Passe",
                textInputAction: TextInputAction.done,
                validateFunction: Validations.validatePassword,
                submitAction: () => viewModel.login(context),
                obscureText: true,
                onSaved: (String val) {
                  viewModel.setPassword(val);
                },
                focusNode: viewModel.passFN,
              ),
              SizedBox(height: 10.0),
              Container(
                height: 45.0,
                width: 180.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFF33346)),
                  ),
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () => viewModel.login(context),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ));
  }
}
