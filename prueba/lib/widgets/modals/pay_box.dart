/* ***************************************************************
 * @author       : Ángel Valdiviezo
 * @model        : PagoPluxModel
 * @description  : Componente modal que presenta el botón de pagos
 * @version  : v1.0.0
 * @copyright (c)  PagoPlux 2021
 *****************************************************************/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:prueba/environments/index.dart';
import 'package:prueba/models/index.dart';

ColoresApp objColoresAppModal = new ColoresApp();
final storagePayBox = const FlutterSecureStorage();

//ignore: must_be_immutable
class ModalPagoPluxView extends StatelessWidget {
  final PagoPluxModel? pagoPluxModel;
  Function? onClose;

  ModalPagoPluxView({@required this.pagoPluxModel, @required this.onClose});

  /*
   * Se construye la vista 
   */
  @override
  Widget build(BuildContext context) {
    String url = Uri.dataFromString(getHTML(this.pagoPluxModel!),
            mimeType: 'text/html', encoding: Encoding.getByName('UTF-8'))
        .toString();

    return Material(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Pago Plux - Test Angel Valdiviezo',
                    style: TextStyle(fontSize: 16)),
                backgroundColor: objColoresAppModal.pluxAzul,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.close_sharp),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
                centerTitle: false)),
        body: SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.all(8),
              child: WebviewScaffold(
                url: url,
                javascriptChannels: Set.from([
                  JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage respuestaPage) {
                      try {
                        final responseModel =
                            PagoResponseModel.fromJson(respuestaPage.message);

                        this.onClose = obtenerDatos(responseModel);
                        //storagePayBox.write(key: 'objRespuestaPago', value: responseModel.toJson());
                        storagePayBox.write(
                            key: 'objRespuestaPago',
                            value: respuestaPage.message);

/*
                        final cambiaEstado = BlocProvider.of<EstadosBloc>(context);
                        cambiaEstado.setRespuestaModel(responseModel);

                        if(responseModel.code == 500){
                          cambiaEstado.setCierraUsuarioModal(true);
                        } else {
                          cambiaEstado.setCierraUsuarioModal(false);
                        }
*/

                        Navigator.of(context).pop();
                      } catch (Ex) {
                        print('Test Error: ${Ex}');
                      }
                    },
                  )
                ].toSet()),
                mediaPlaybackRequiresUserGesture: false,
                withZoom: false,
                withLocalStorage: true,
                hidden: false,
                enableAppScheme: true,
                allowFileURLs: true,
                initialChild: Container(
                  color: Colors.white10,
                  child: const Center(
                    child: Text('Cargando....',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  String getUrl(PagoPluxModel pagoPluxModel) {
    String url = '';
    switch (pagoPluxModel.payboxEnvironment) {
      case 'product':
        url = CadenaConexion.product;
        break;
      case 'prod':
        url = CadenaConexion.prod;
        break;
      default:
        url = CadenaConexion.sandbox;
        break;
    }
    return url;
  }

  String getHTML(PagoPluxModel pagoPluxModel) {
    String html = '<html>';
    html += ' <body><form action="${getUrl(pagoPluxModel)}/movil.html">';
    html +=
        '<input type="hidden" value="${pagoPluxModel.payboxRemail!}" name="PayboxRemail">';

    if (pagoPluxModel.payboxRename != null) {
      html +=
          '<input type="hidden" value="${Uri.encodeFull(pagoPluxModel.payboxRename!)}" name="PayboxRename">';
    }
    if (pagoPluxModel.payboxSendmail != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxSendmail!}" name="PayboxSendmail">';
    }
    if (pagoPluxModel.payboxSendname != null) {
      html +=
          '<input type="hidden" value="${Uri.encodeFull(pagoPluxModel.payboxSendname!)}" name="PayboxSendname">';
    }
    if (pagoPluxModel.payboxDescription != null) {
      html +=
          '<input type="hidden" value="${Uri.encodeFull(pagoPluxModel.payboxDescription!)}" name="PayboxDescription">';
    }
    if (pagoPluxModel.payboxBase0 != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxBase0}" name="PayboxBase0">';
    }
    if (pagoPluxModel.payboxBase12 != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxBase12}" name="PayboxBase12">';
    }
    if (pagoPluxModel.payboxEnvironment != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxEnvironment!}" name="PayboxEnvironment">';
    }

    html +=
        '<input type="hidden" value="${pagoPluxModel.payboxProduction.toString()}" name="PayboxProduction">';

    if (pagoPluxModel.payboxDirection != null) {
      html +=
          '<input type="hidden" value="${Uri.encodeFull(pagoPluxModel.payboxDirection!)}" name="PayboxDirection">';
    }
    if (pagoPluxModel.payboxClientName != null) {
      html +=
          '<input type="hidden" value="${Uri.encodeFull(pagoPluxModel.payboxClientName!)}" name="PayboxClientName">';
    }
    if (pagoPluxModel.payboxClientName != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxClientIdentification!}" name="PayboxClientIdentification">';
    }
    if (pagoPluxModel.payboxClientPhone != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxClientPhone!}" name="PayboxClientPhone">';
    }
    if (pagoPluxModel.payboxCreditType != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxCreditType!}" name="PayboxCreditType">';
    }
    if (pagoPluxModel.payboxInteres != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxInteres!}" name="PayboxInteres">';
    }
    if (pagoPluxModel.payboxIdPlan != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxIdPlan!}" name="PayboxIdPlan">';
    }
    if (pagoPluxModel.payboxCobroPrueba != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxCobroPrueba.toString()}" name="PayboxCobroPrueba">';
    }
    if (pagoPluxModel.payboxGraceMonths != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxGraceMonths.toString()}" name="PayboxGraceMonths">';
    }
    if (pagoPluxModel.payboxIntoDataPayment != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxIntoDataPayment.toString()}" name="PayboxIntoDataPayment">';
    }
    if (pagoPluxModel.payboxNumInstallments != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxNumInstallments.toString()}" name="PayboxNumInstallments">';
    }
    if (pagoPluxModel.payboxRecurrent != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxRecurrent.toString()}" name="PayboxRecurrent">';
    }
    if (pagoPluxModel.payboxPermitirCalendarizar != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxPermitirCalendarizar.toString()}" name="PayboxPermitirCalendarizar">';
    }
    if (pagoPluxModel.payboxPagoInmediato != null) {
      html +=
          '<input type="hidden" value="${pagoPluxModel.payboxPagoInmediato.toString()}" name="PayboxPagoInmediato">';
    }

    html += '</form>';
    html += '<script>';
    html += 'document.forms[0].submit();';
    html += '</script>';
    html += '</body>';
    html += '</html>';
    return html;
  }
}

obtenerDatos(PagoResponseModel datos) {
  //voucher = 'Voucher: ' + datos.detail!.token!;
  //setState(() {});
  //print('LLegoooo 2' + datos.detail!.token!);
}
