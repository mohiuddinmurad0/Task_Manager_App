// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';
import 'package:task_manager_flutter/ui/screens/auth_screens/otp_varification.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/signup_button.dart';

class EmailVarificationScreeen extends StatefulWidget {
  const EmailVarificationScreeen({Key? key}) : super(key: key);

  @override
  State<EmailVarificationScreeen> createState() =>
      _EmailVarificationScreeenState();
}

class _EmailVarificationScreeenState extends State<EmailVarificationScreeen> {
  final TextEditingController _emailTEController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> emailVerify(String email) async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(ApiLinks.recoverVerifyEmail(email));

    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                    email: _emailTEController.text.trim(),
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid email address"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  dispose() {
    super.dispose();
    _emailTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Please enter your email address to receive a verification code",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 16),
                Form(
                    key: _emailFormKey,
                    child: CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,5}')
                                .hasMatch(value)) {
                          return "please Enter your correct Email";
                        } else {
                          return null;
                        }
                      },
                      hintText: "Email",
                      controller: _emailTEController,
                      textInputType: TextInputType.emailAddress,
                    )),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _isLoading == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_emailFormKey.currentState!.validate()) {
                          emailVerify(_emailTEController.text.trim());
                        }
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SignUpButton(
                  text: "Have An Account?",
                  onPresse: () {
                    Navigator.pop(context);
                  },
                  buttonText: 'Sign In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
