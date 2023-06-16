import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        // navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Flexible(
              child: Container(),
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              height: 64,
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            const SizedBox(
              height: 32,
            ),
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _image != null ? MemoryImage(_image!) : null,
                  backgroundColor: Colors.amber,
                  radius: 64,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                hintText: "E-mail",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Username",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Password",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _bioController,
                hintText: "Bio",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: signUpUser,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    color: blueColor,
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text('Sign up')),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text('Already have an account?'),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Log in.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
