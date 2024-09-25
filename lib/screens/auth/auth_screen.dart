import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketwave/screens/auth/login/login_screen.dart';
import 'package:ticketwave/screens/auth/otp/otp_screen.dart';
import 'package:ticketwave/screens/auth/registration/registration.dart';

import '../../config/functions.dart';
import '../../providers/providers.dart';
import '../../remote_service/remote_service.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static String routeName = "authScreen";
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isAppExpanded = true;
  bool isEmail = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _heightAnimation = Tween<double>(
      begin: Functions.contextSize(context).height / 2.8,
      end: 0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleTextField() {
    setState(() {
      isEmail = !isEmail;
    });
  }

  void _toggleHeight() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      isAppExpanded = !isAppExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        highlightColor: Colors.transparent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: <Widget>[
            AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                return SliverAppBar.large(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  expandedHeight: _heightAnimation.value,
                  leading: Container(),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.all(0),
                    background: SafeArea(
                      child: Image.asset(
                        'assets/images/people.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  pinned: true,
                );
              },
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: isAppExpanded
                            ? const Offset(0, -1) // From top to bottom
                            : const Offset(0, 1), // From bottom to top
                        end: Offset.zero,
                      ).animate(animation);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    child: isAppExpanded
                        ? RegistrationScreen(
                            key: const ValueKey('RegistrationScreen'),
                            phoneController: _phoneController,
                            emailController: _emailController,
                            toggleAppBar: _toggleHeight,
                            toggleTextField: _toggleTextField,
                            isEmail: isEmail,
                            onSubmit: () => _onSubmit(),
                          )
                        : LoginScreen(
                            key: const ValueKey('LoginScreen'),
                            loginController:
                                isEmail ? _emailController : _phoneController,
                            passwordController: _passwordController,
                            toggleAppBar: _toggleHeight,
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (isEmail) {
      // email check process
      if (_emailController.text.isEmpty) {
        Functions.showToast(msg: 'Renseignez votre adresse email');
        return;
      }
      // Définir la regex
      final RegExp emailPatern =
          RegExp(r"^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$");
      if (!emailPatern.hasMatch(_emailController.text)) {
        Functions.showToast(msg: 'Adresse email invalide');
        return;
      }
      // call api
      EasyLoading.show();
      Map<String, dynamic> _payload = {
        'email': _emailController.text,
      };
      await RemoteService()
          .postSomethings(
        api: 'users/verify',
        data: _payload,
      )
          .then((r) {
        EasyLoading.dismiss();
        if (r.statusCode == 401) {
          var json = jsonDecode(r.body);
          Navigator.of(context).pushNamed(
            OtpScreen.routeName,
            arguments: OTPScrenArgs(
              login: _emailController.text,
              isEmail: true,
              otp: json['otp'],
              title: 'Vérification de votre adresse email',
            ),
          );
        } else if (r.statusCode == 200 || r.statusCode == 201) {
          // take user infos
          Functions.showToast(msg: 'Une compte existe déjà pour cet email');
          _toggleHeight();
        }
      });
      // EasyLoading.dismiss();
    } else {
      // phone number check process
      if (_phoneController.text.isEmpty) {
        Functions.showToast(msg: 'Renseignez votre numéro de téléphone');
        return;
      }
      //
      final zipcode = await ref.read(selectedCountryProvider)?.zipCode;
      print(zipcode);
    }
  }
}
