import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import '../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
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
                const CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 64,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: () => {},
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
              onTap: () => {},
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
                child: const Text('Sign up'),
              ),
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
                  onTap: () => {},
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
