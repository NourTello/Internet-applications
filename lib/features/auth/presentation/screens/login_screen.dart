import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/features/auth/presentation/screens/register_screen.dart';
import 'package:web_app/features/group/presentation/screens/all_groups_screen.dart';
import 'package:web_app/features/layout/presentation/screens/layout_screen.dart';
import '../../../../core/componant/app-text-field.dart';
import '../../../../core/componant/material-button-componat.dart';
import '../../../../core/componant/text_style.dart';
import '../../../../core/const/light-colors.dart';
import '../../../../core/const/string_const.dart';
import '../../data/repo/auth_repo.dart';
import '../../domain/bloc/auth_bloc.dart';
import '../../domain/bloc/auth_event.dart';
import '../../domain/bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthBloc loginBloc = AuthBloc(authRepo: AuthRepo());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => loginBloc,
        child: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is LoginSuccessState)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeLayoutScreen()));

        }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          AuthBloc bloc =AuthBloc.get(context);
          return SafeArea(
            child: Scaffold(
                body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                      key: loginFormKey,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: backgroundColor,
                          ),
                          width: 500,
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      'Sign in ',
                                      style: titleTextStyle(size: 30),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldComponent(
                                      verticalPadding: 40,
                                      controller: emailController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return StringConst.emptyValidate;
                                        }
                                        return null; // البريد الإلكتروني صالح
                                      },
                                      textInputType: TextInputType.emailAddress,
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: darkGrey,
                                      ),
                                      hintText: "Enter email",
                                      labelText: "email",
                                    ),
                                    TextFieldComponent(
                                      controller: passwordController,
                                      textInputType: TextInputType.text,
                                      labelText: "password",
                                      hintText: "Enter Password",
                                      obscureText: isObscureText,
                                      prefixIcon:
                                          Icon(Icons.lock, color: darkGrey),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          isObscureText = !isObscureText;
                                          context
                                              .read<AuthBloc>()
                                              .add(LoginShowPasswordEvent());
                                        },
                                        icon: isObscureText
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: darkGrey,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: primaryColor,
                                              ),
                                      ),
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return StringConst.emptyValidate;
                                        }
                                        if (value.length < 8)
                                          return StringConst
                                              .shortPasswordValidate;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    (state is LoginLoadingState)?CircularProgressIndicator():
                                    MaterialButtonComponent(
                                      width: 200,
                                      verticalMargin: 20,
                                      onPressed: () {
                                        if(loginFormKey.currentState!.validate()) {
                                          bloc.add(LoginEvent(email: emailController.text, password: passwordController.text));
                                        }
                                        // if (loginFormKey.currentState!.validate())
                                        // { context.read<AuthBloc>().add(
                                        //     LoginEvent( email: emailController.text, password: passwordController.text,)
                                        // );
                                       // }

                                      },
                                      child: Text("Sign in",
                                          style: buttonTextStyle()),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Don\'t have an account?',
                                          style: greyTextStyle(),
                                        ),
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterScreen())),
                                            child: Text(
                                              'Sign up ',
                                              style: TextStyle(
                                                  color: secondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    )
                                    // LoginForgetPasswordButton(),
                                    // LoginCreatAccountRow()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            )),
          );
        })));
  }
}
