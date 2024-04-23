import 'dart:html';

import 'package:flutter/material.dart';

class Cuenta extends StatefulWidget {
  const Cuenta({Key? key}) : super(key: key);

  @override
  State<Cuenta> createState() => _CuentaState();
}

class _CuentaState extends State<Cuenta> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contController = TextEditingController();
  final TextEditingController _confircontController = TextEditingController();

  bool isVisibleObsecure = false;

  void _submittedForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Formulario con exito"),
        ),
      );
    }
  }

  String? ValidateName(String? value) {
    if (value!.isEmpty) {
      return "Ingresa tu nombre otra vez";
    } else if (RegExp(r"^[a-zA-Z+$]").hasMatch(value)) {
      return "Por favor ingresa un valido nombre sin numeros o caracteres especiales";
    }
    return null;
  }

  String? ValidateEmail(String? value) {
    if (value!.isEmpty) {
      return "Ingresa tu email otra vez";
    } else if (RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "Por favor ingresa un valido correo";
    }
    return null;
  }

  String? ValidateCont(String? value, String? text) {
    if (value!.isEmpty) {
      return "Ingresa tu contraseña otra vez";
    } else if (RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
      return "Por favor ingresa una valida contraseña";
    }
    return null;
  }

  String? ValidateConfirCont(String? value, String? text) {
    if (value!.isEmpty) {
      return "Por favor confirma la contraseña";
    } else if (value != text) {
      return "Las contraseñas no coinciden";
    }
    return ValidateCont(value, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/logo.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Crear \n Nueva cuenta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                            height: 1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) => ValidateName(value),
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person), hintText: "Nombre"),
                      ),
                      TextFormField(
                        validator: (value) => ValidateEmail(value),
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email), hintText: "Email"),
                      ),
                      TextFormField(
                        validator: (value) =>
                            ValidateCont(value, _contController.text),
                        controller: _contController,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: isVisibleObsecure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisibleObsecure = isVisibleObsecure;
                                  });
                                },
                                icon: isVisibleObsecure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            prefixIcon: Icon(Icons.password),
                            hintText: "Constraseña"),
                      ),
                      TextFormField(
                        validator: (value) =>
                            ValidateConfirCont(value, _contController.text),
                        controller: _confircontController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: "Confirmar contraseña"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            minimumSize: Size(400, 50)),
                        onPressed: () {
                          _submittedForm();
                        },
                        child: Text(
                          "Crear",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
