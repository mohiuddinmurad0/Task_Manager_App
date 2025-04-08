import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_flutter/data/models/auth_utility.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_password_text_field.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/user_banners.dart';

import '../../data/models/login_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  Data userInfo = AuthUtility.userInfo.data!;
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

  XFile? pickImage;
  String? base64Image;
  @override
  void initState() {
    super.initState();
    _emailController.text = AuthUtility.userInfo.data?.email ?? "";
    _firstNameController.text = AuthUtility.userInfo.data?.firstName ?? "";
    _lastNameController.text = AuthUtility.userInfo.data?.lastName ?? "";
    _phoneNumberController.text = AuthUtility.userInfo.data?.mobile ?? "";
  }

  Future<void> updateProfile() async {
    _signUpInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "phoneNumber": _phoneNumberController.text.trim(),
      "photos": ""
    };
    if (_passwordController.text.isNotEmpty) {
      requestBody["password"] = _passwordController.text;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(ApiLinks.profileUpdate, requestBody);
    _signUpInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userInfo.firstName = _firstNameController.text.trim();
      userInfo.lastName = _lastNameController.text.trim();
      userInfo.mobile = _phoneNumberController.text.trim();
      _passwordController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile update Successful"),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile update Failed"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userBanner(context),
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Update Profile",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    imagePicked();
                  },
                  child: Row(children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Text("Photos"),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          pickImage?.name ?? "",
                          maxLines: 1,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: "Email",
                  readOnly: true,
                  controller: _emailController,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hintText: "First Name",
                  controller: _firstNameController,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hintText: "Last Name",
                  controller: _lastNameController,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hintText: "Phone Number",
                  controller: _phoneNumberController,
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true && value?.length != 11) {
                      return "Please enter phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomPasswordTextFormField(
                  obscureText: true,
                  hintText: "Password",
                  controller: _passwordController,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _signUpInProgress == false,
                  replacement:
                      const Center(child: CupertinoActivityIndicator()),
                  child: CustomButton(
                    onPresse: () {
                      updateProfile();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void imagePicked() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pick Image From:'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () async {
                    pickImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickImage != null) {
                      setState(() {});
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } else {}
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  onTap: () async {
                    pickImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickImage != null) {
                      setState(() {});
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } else {}
                  },
                  title: const Text('Gallery'),
                )
              ],
            ),
          );
        });
  }
}
