import 'dart:io';

import 'package:flutter/material.dart';
import 'package:precomedio/modules/app/view/app_screen.dart';
import 'package:precomedio/modules/compra/controller/compra_controller.dart';
import 'package:precomedio/modules/compra/view/compra_add.dart';
import 'package:precomedio/modules/compra/view/compra_ativo_screen.dart';
import 'package:precomedio/modules/compra/view/compra_edit.dart';
import 'package:precomedio/modules/compra/view/compra_ativo_add.dart';
import 'package:precomedio/modules/compra/view/compra_screen.dart';
import 'package:precomedio/modules/ticket/controller/ticket_controller.dart';
import 'package:precomedio/modules/ticket/view/ticket_add.dart';
import 'package:precomedio/modules/ticket/view/ticket_edit.dart';
import 'package:precomedio/modules/ticket/view/ticket_screen.dart';
import 'package:precomedio/modules/app/view/tabs_screen.dart';
import 'package:precomedio/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TicketController(),
          ),
          ChangeNotifierProvider(
            create: (context) => CompraController(),
          ),
        ],
        child: MaterialApp(
          title: 'Preço médio',
          theme: ThemeData(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Colors.cyan,
                    secondary: Colors.amber,
                    tertiary: Colors.cyan.shade900,
                    inversePrimary: Colors.white,
                  ),
              fontFamily: 'RobotoCondensed',
              textTheme: ThemeData().textTheme.copyWith(
                  headline1: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          initialRoute: '/',
          routes: {
            AppRoutes.HOME: (ctx) => const TabsScreen(),
            AppRoutes.LISTA: (ctx) => const ListaScreen(),
            AppRoutes.COMPRA_LIST: (ctx) => const CompraScreen(),
            AppRoutes.COMPRA_ADD: (ctx) => const CompraAddScreen(),
            AppRoutes.COMPRA_EDIT: (ctx) => const CompraEditScreen(),
            AppRoutes.COMPRA_ATIVO_LIST: (ctx) => const CompraAtivoScreen(),
            AppRoutes.COMPRA_ATIVO_ADD: (ctx) => const CompraAtivoAddScreen(),
            AppRoutes.TICKET_LIST: (ctx) => const TicketScreen(),
            AppRoutes.TICKET_ADD: (ctx) => const TicketAddScreen(),
            AppRoutes.TICKET_EDIT: (ctx) => const TicketEditScreen(),
          },
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
