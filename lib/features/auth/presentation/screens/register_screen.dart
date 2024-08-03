import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  final AuthBloc registerBloc = AuthBloc(authRepo: AuthRepo());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => registerBloc,
        child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is RegisterSuccessState)
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeLayoutScreen()));
            },
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              var bloc = AuthBloc.get(context);
              return SafeArea(
                child: Scaffold(
                    backgroundColor: thirdColor,
                    body: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
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
                                        'Sign up ',
                                        style: titleTextStyle(size: 30),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFieldComponent(
                                        // verticalPadding: 20,
                                        controller: nameController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return StringConst.emptyValidate;
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.name,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: darkGrey,
                                        ),
                                        hintText: "Username",
                                      ),
                                      TextFieldComponent(
                                        verticalPadding: 40,
                                        controller: emailController,
                                        validate: (value) {
                                          if (value!.isEmpty)
                                            return StringConst.emptyValidate;
                                          else if (!value.contains('@') ||
                                              !value.contains('gmail.com'))
                                            return 'Enter email address';
                                          return null; // البريد الإلكتروني صالح
                                        },
                                        textInputType:
                                            TextInputType.emailAddress,
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: darkGrey,
                                        ),
                                        hintText: "Email address",
                                      ),
                                      TextFieldComponent(
                                        controller: passwordController,
                                        textInputType: TextInputType.text,
                                        hintText: "Password",
                                        obscureText: isObscureText,
                                        prefixIcon:
                                            Icon(Icons.lock, color: darkGrey),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            isObscureText = !isObscureText;
                                            context.read<AuthBloc>().add(
                                                RegisterShowPasswordEvent());
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
                                      (state is RegisterLoadingState)
                                          ? CircularProgressIndicator()
                                          : MaterialButtonComponent(
                                              verticalMargin: 20,
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  bloc.add(RegisterEvent(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      name:
                                                          nameController.text));
                                                }
                                              },
                                              child: Text("Sign up",
                                                  style: buttonTextStyle()),
                                            ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Already have an account ?',
                                            style: greyTextStyle(),
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen())),
                                              child: Text(
                                                'Sign in ',
                                                style: TextStyle(
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      )
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
