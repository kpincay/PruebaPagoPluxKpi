import 'dart:core';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
//ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' hide ModalBottomSheetRoute;
import 'package:prueba/environments/index.dart';
import 'package:prueba/models/index.dart';
import 'package:prueba/screens/index.dart';
import 'package:prueba/screens/input_decoration.dart';
import 'package:prueba/screens/modals/pay_box.dart';
import 'package:prueba/utils/index.dart';
//import 'package:prueba/utils/index.dart';
//ignore: unused_import
//import 'package:prueba/utils/index.dart';
//ignore: unused_import
import 'package:flutter/services.dart';
//ignore: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
////import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:prueba/screens/animations/fade_animation.dart';

String voucher = 'Pendiente Pago';
ColoresApp objColoresAppForms = ColoresApp();
String nombreGenPago = '';
String correoGenPago = '';
PagoPluxModel paymentModel = new PagoPluxModel();
String tituloMensajeError = 'Error al registrar datos';
const storagePagoFrm = FlutterSecureStorage();

//ignore: must_be_immutable
class PagosFrmScreen extends StatefulWidget {
  String nombre = '';
  String correo = '';

  PagosFrmScreen({Key? key, nombre, correo}) : super(key: key) {
    nombreGenPago = nombre ?? '';
    correoGenPago = correo ?? '';
  }

  static const String routerName = 'pagosFrmScreen';

  @override
  PagosFrmScreenState createState() => PagosFrmScreenState();
}

class PagosFrmScreenState extends State<PagosFrmScreen>
    with TickerProviderStateMixin {
  bool hideIcon = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _widthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _positionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _scale2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController!.forward();
            }
          });

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController!.forward();
            }
          });

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller!.forward();
            }
          });

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Future.microtask(() => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HistorialCobroScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  )));
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
  }

  AnimationController? _scaleController;
  AnimationController? _scale2Controller;
  AnimationController? _widthController;
  AnimationController? _positionController;

  Animation<double>? _scaleAnimation;
  Animation<double>? _scale2Animation;
  Animation<double>? _widthAnimation;
  Animation<double>? _positionAnimation;

  @override
  Widget build(BuildContext context) {
    //  builder: (context, listen: false) {
    //     // No longer throws
    //     return Text(context.watch<Example>().toString());
    //   }
    final sizeFrmDatosPers = MediaQuery.of(context).size;

    //ignore: unnecessary_string_escapes
    var regexToRemoveEmoji =
        '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';
    openPpx();

    obtenerDatos(PagoResponseModel datos) {
      voucher = 'Voucher: ' + datos.detail!.token!;
      setState(() {});
    }

    final pagoServiceForm = Provider.of<PagoService>(context, listen: false);
    pagoServiceForm.correo = correoGen;

    return SafeArea(
      child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
              width: sizeFrmDatosPers.width,
              height: sizeFrmDatosPers.height,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: pagoServiceForm.formKey,
                child: Container(
                  color: Colors.transparent,
                  width: sizeFrmDatosPers.width,
                  height: sizeFrmDatosPers.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.1,
                          child: Center(
                            child: AutoSizeText(
                              'Formulario PagoPlux',
                              style: TextStyle(
                                  color: objColoresAppForms.pluxVerde),
                              maxLines: 1,
                              presetFontSizes: const [20, 18, 16, 14, 12, 10],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.003,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.13,
                          child: TextFormField(
                            onChanged: (value) {
                              pagoServiceForm.varNombre = value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(regexToRemoveEmoji))
                            ],
                            //controller: txtNombre,
                            style: const TextStyle(color: Colors.black),
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            initialValue: pagoServiceForm.varNombre,
                            decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                varEsContrasenia: false,
                                colorBordes: objColoresAppForms.pluxAzul,
                                colorTexto: objColoresAppForms.pluxAzul,
                                varTamanioIcono: 35,
                                hintText: '',
                                labelText: 'Nombres',
                                varOnPress: () {}),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.007,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.13,
                          child: TextFormField(
                            onChanged: (value) {
                              pagoServiceForm.varIdentificacion = value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(regexToRemoveEmoji))
                            ],
                            initialValue: pagoServiceForm.varIdentificacion,
                            style: const TextStyle(color: Colors.black),
                            maxLines: 1,
                            minLines: 1,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                varEsContrasenia: false,
                                colorBordes: objColoresAppForms.pluxNaranja,
                                colorTexto: objColoresAppForms.pluxNaranja,
                                varTamanioIcono: 35,
                                hintText: '',
                                labelText: 'Identificación',
                                varOnPress: () {}),
                            validator: (value) {
                              String respt = 'Ok';
                              if (value != null &&
                                  value != '' &&
                                  value.length > 9) {
                                respt = ValidacionesUtils()
                                    .validaCedula(value.toString());
                              }
                              var esIdentificacionInvalida = false;
                              if (respt != 'Ok') {
                                esIdentificacionInvalida = true;
                              } else {
                                esIdentificacionInvalida = false;
                              }

                              return respt == 'Ok' ? null : 'Cédula inválida.';
                            },
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.007,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.13,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(regexToRemoveEmoji))
                            ],
                            initialValue: pagoServiceForm.varTelefono,
                            onChanged: (value) {
                              pagoServiceForm.varTelefono = value;
                            },
                            //controller: txtTelefono,
                            style: const TextStyle(color: Colors.black),
                            maxLines: 1,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                varEsContrasenia: false,
                                colorBordes: objColoresAppForms.pluxAzul,
                                colorTexto: objColoresAppForms.pluxAzul,
                                varTamanioIcono: 35,
                                hintText: '',
                                labelText: 'Número de teléfono',
                                varOnPress: () {}),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.007,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.13,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(regexToRemoveEmoji))
                            ],
                            onChanged: (value) {
                              pagoServiceForm.varCorreo = value;
                            },
                            style: const TextStyle(color: Colors.black),
                            maxLines: 1,
                            maxLength: 50,
                            initialValue: pagoServiceForm.correo,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                varEsContrasenia: false,
                                colorBordes: objColoresAppForms.pluxNaranja,
                                colorTexto: objColoresAppForms.pluxNaranja,
                                varTamanioIcono: 35,
                                hintText: '',
                                labelText: 'Correo',
                                varOnPress: () {}),
                            validator: (value) {
                              String respt = 'Ok';

                              if (correoGenPago.isNotEmpty && value == null) {
                                value = correoGenPago;
                              }

                              if (value != null && value != '') {
                                respt = ValidacionesUtils()
                                    .validaCorreo(value.toString());
                              }

                              return respt != 'Ok' ? null : 'Correo inválido.';
                            },
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.007,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.13,
                          child: TextFormField(
                            initialValue: pagoServiceForm.varPago,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(regexToRemoveEmoji))
                            ],
                            //controller: txtPago,
                            onChanged: (value) {
                              pagoServiceForm.varPago = value;
                            },
                            style: const TextStyle(color: Colors.black),
                            maxLines: 1,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                varEsContrasenia: false,
                                colorBordes: objColoresAppForms.pluxAzul,
                                colorTexto: objColoresAppForms.pluxAzul,
                                varTamanioIcono: 35,
                                hintText: '',
                                labelText: 'Valor de pago',
                                varOnPress: () {}),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.007,
                        ),
                        Container(
                          color: Colors.transparent,
                          width: sizeFrmDatosPers.width * 0.85,
                          height: sizeFrmDatosPers.height * 0.13,
                          child: TextFormField(
                            initialValue: pagoServiceForm.varDireccion,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(regexToRemoveEmoji))
                            ],
                            //controller: txtDireccion,
                            onChanged: (value) {
                              pagoServiceForm.varDireccion = value;
                            },
                            style: const TextStyle(color: Colors.black),
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                varEsContrasenia: false,
                                colorBordes: objColoresAppForms.pluxNaranja,
                                colorTexto: objColoresAppForms.pluxNaranja,
                                varTamanioIcono: 35,
                                hintText: '',
                                labelText: 'Dirección',
                                varOnPress: () {}),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();

                                pagoServiceForm.varCorreo =
                                    pagoServiceForm.varCorreo.isEmpty
                                        ? correoGenPago
                                        : pagoServiceForm.varCorreo;

                                String mensajeValidacion =
                                    pagoServiceForm.validaDatos();

                                if (mensajeValidacion.isNotEmpty) {
                                  CustomBgAlertBox(
                                    context: context,
                                    title: tituloMensajeError,
                                    infoMessage: mensajeValidacion,
                                    buttonColor: Colors.red,
                                    buttonText: 'Cerrar',
                                    icon: Icons.cancel,
                                    titleTextColor: Colors.red[400],
                                  );
                                  return;
                                }

                                await showBarModalBottomSheet(
                                    topControl:
                                        crearTop(context, sizeFrmDatosPers),
                                    useRootNavigator: true,
                                    elevation: 5,
                                    expand: true,
                                    context: context,
                                    builder: (context) => ModalPagoPluxView(
                                          pagoPluxModel: paymentModel,
                                          onClose: obtenerDatos,
                                        ));

                                PagoResponseModel? objRespuest;

                                var objTmp = await storagePagoFrm.read(
                                        key: 'objRespuestaPago') ??
                                    '';
                                if (objTmp != '') {
                                  objRespuest =
                                      PagoResponseModel.fromJson(objTmp);
                                }

                                if (objRespuest != null &&
                                    objRespuest.respuestaEnviada! &&
                                    objRespuest.code == 0) {
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  pagoServiceForm.LimpiaCampos();
                                  _scaleController!.forward();
                                }
                              },
                              child: const Text('Ingresar'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrmDatosPers.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

Widget crearTop(BuildContext context, Size objSize) {
  return Container(height: objSize.height * 0.12);
}

openPpx() {
  paymentModel = PagoPluxModel(
      payboxBase0: 1.0,
      payboxBase12: 2.212,
      payboxDescription: 'Pago desde Flutter',
      payboxEnvironment: 'sandbox',
      payboxProduction: false,
      payboxRemail: 'da.nielrolesppx@gmail.com',
      payboxRename: 'PagoPlux Shop',
      payboxSendmail: 'jhondoe@gmail.com',
      payboxSendname: 'JHON DOE');
}
