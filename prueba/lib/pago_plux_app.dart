import 'package:prueba/main.dart';
import 'package:prueba/screens/login.dart';
import 'package:prueba/screens/pagos_frm_screen.dart';
import 'package:prueba/services/index.dart';

import 'package:flutter/material.dart';
import 'package:prueba/screens/index.dart';
import 'package:provider/provider.dart';
import 'package:prueba/widgets/scale_text_widget.dart';

// import '/src/widgets/index.dart';

class PagoPluxApp extends StatefulWidget {
  const PagoPluxApp({Key? key}) : super(key: key);

  @override
  State<PagoPluxApp> createState() => PagoPluxAppState();
}

class PagoPluxAppState extends State<PagoPluxApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProspectoTypeService('', ''),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AutenticacionService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => PagoService(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
          builder: (varContext, varChild) {
            return MaxScaleTextWidget(
              max: 1.0,
              child: varChild,
            );
          },
          debugShowCheckedModeBanner: false,
          title: '',
          initialRoute: Login.routerName,
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: messengerKey,
          home: PrincipalScreen(),
          theme: ThemeData(
            primaryColor: Colors.black,
            appBarTheme: const AppBarTheme(
              color: Colors.black,
            ),
          ),
          routes: {
            HistorialCobroScreen.routerName: (_) => HistorialCobroScreen(),
            PagosFrmScreen.routerName: (_) => PagosFrmScreen(),
            Login.routerName: (_) => const Login(title: 'Pago Plux Demo'),
          }),
    );
  }
}
