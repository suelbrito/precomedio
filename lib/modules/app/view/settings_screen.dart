import 'package:flutter/material.dart';
import 'package:precomedio/modules/app/view/camera_screen.dart';
import 'package:precomedio/utils/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Tire sua foto'),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraScreen(),
                              fullscreenDialog: true)),
                    ),
                    // Blue
                  ],
                ),
              )),
        ));
  }
}
