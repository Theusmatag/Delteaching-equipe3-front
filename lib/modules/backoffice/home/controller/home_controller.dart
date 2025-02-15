import 'dart:convert';
import 'dart:developer';

import 'package:dealteachingfront/services/global_state_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';

class HomePageController extends ChangeNotifier {
  bool isLoading = false;
  TextEditingController nome = TextEditingController();
  TextEditingController dataNascimento = TextEditingController();
  TextEditingController agencia = TextEditingController();
  TextEditingController documento = TextEditingController();
  TextEditingController email = TextEditingController();
  String? selectedOption;
  String? nameInvalid;
  String? dateInvalid;
  String? agencyInvalid;
  String? documentInvalid;
  String? emailInvalid;
  String? holderType;
  String? accountType;
  final dioClient = Dio();

  formClear() {
    nome.clear();
    dataNascimento.clear();
    agencia.clear();
    documento.clear();
    email.clear();
    selectedOption = null;
  }

  validateNome(String nome) {
    if (nome.isNotEmpty) {
      RegExp rex = RegExp(
          r"^\s*([A-Za-zà-úÀ-Ú]{1,}([\.,] |[-']| ))+[A-Za-zà-úÀ-Ú]+\.?\s*$");
      if (nome.length >= 10 && rex.hasMatch(nome)) {
        nameInvalid = null;
      } else {
        nameInvalid = "Nome inválido";
      }
    } else {
      nameInvalid = "Nome inválido";
    }
  }

  validateData(String date) {
    if (date.isNotEmpty) {
      if (date.length == 10) {
        dateInvalid = null;
      } else {
        dateInvalid = "Data inválida";
      }
    } else {
      dateInvalid = "Data inválida";
    }
  }

  validateAgencia(String agency) {
    if (agency.isNotEmpty) {
      agencyInvalid = null;
    } else {
      agencyInvalid = "Agência inválida";
    }
  }

  validateDocument(String document) {
    if (document.length == 14 || document.length == 18) {
      if (isValidCpf(document)) {
        documentInvalid = null;
        holderType = 'NATURAL';
      } else if (isValidCnpj(document)) {
        documentInvalid = null;
        holderType = 'LEGAL';
      }
    } else {
      documentInvalid = "Documento inválido";
    }
  }

  validadorEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com)(\.br)?$');
    if (emailRegex.hasMatch(email)) {
      emailInvalid = null;
    } else {
      emailInvalid = 'E-mail inválido';
    }
  }

  bool isValidCpf(String cpf) {
    if (cpf == '') return false;

    var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (numeros.length != 11) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    var calcDv1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digitos[10 - i] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digitos[9] != dv1) return false;

    var calcDv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digitos[11 - i] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digitos[10] != dv2) return false;

    return true;
  }

  bool isValidCnpj(String cnpj) {
    var numeros = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    if (numeros.length != 14) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    var calcDv1 = 0;
    var j = 0;
    for (var i in Iterable<int>.generate(12, (i) => i < 4 ? 5 - i : 13 - i)) {
      calcDv1 += digitos[j++] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digitos[12] != dv1) return false;

    var calcDv2 = 0;
    j = 0;
    for (var i in Iterable<int>.generate(13, (i) => i < 5 ? 6 - i : 14 - i)) {
      calcDv2 += digitos[j++] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digitos[13] != dv2) return false;

    return true;
  }

  bool registerValid() {
    bool boolValue = false;
    if (selectedOption != null &&
        nameInvalid == null &&
        dateInvalid == null &&
        agencyInvalid == null &&
        documentInvalid == null &&
        emailInvalid == null &&
        nome.text.isNotEmpty &&
        dataNascimento.text.isNotEmpty &&
        agencia.text.isNotEmpty &&
        documento.text.isNotEmpty &&
        email.text.isNotEmpty) {
      boolValue = true;
      return boolValue;
    } else {
      return boolValue;
    }
  }

  String removerMascara(String documento) {
    return documento.replaceAll(RegExp(r'[\.\-\/]'), '');
  }

  register() async {
    isLoading = true;
    var jasao = jsonEncode({
      "branch": agencia.text,
      "type": selectedOption,
      "holderName": nome.text,
      "holderEmail": email.text,
      "holderDocument": removerMascara(documento.text),
      "holderType": holderType,
      "status": "ACTIVE"
    });
    try {
      var response =
          await dioClient.post('http://172.16.145.13:80/api/BankAccount',
              data: jsonEncode({
                "branch": agencia.text,
                "type": selectedOption,
                "holderName": nome.text,
                "holderEmail": email.text,
                "holderDocument": removerMascara(documento.text),
                "holderType": holderType,
                "status": "ACTIVE"
              }));
      log(jasao);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(KeyGlobalContext.navigatorKey.currentContext!)
            .showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Usuário cadastrado com sucesso')));
        formClear();
      }
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(KeyGlobalContext.navigatorKey.currentContext!)
            .showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Não foi possivel cadastrar o usuário')));
      }
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log(e.response!.statusMessage ?? 'falhou');
      log(jasao);
    }
    isLoading = false;
    notifyListeners();
  }
}
