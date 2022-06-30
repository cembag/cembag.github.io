import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weloggerweb/models/loading.dart';
import 'package:weloggerweb/models/utils.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/providers/providers.dart';
import 'package:weloggerweb/services/firestore.dart';

class DialogAdd extends StatefulWidget {
  const DialogAdd({Key? key}) : super(key: key);

  @override
  State<DialogAdd> createState() => _DialogAddState();
}

class _DialogAddState extends State<DialogAdd> {

  DbService dbService = DbService();

  FieldProvider fieldProvider = FieldProvider();

  final FocusNode numberFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {

    _nameController.addListener(() { 
      fieldProvider.getIsNameFieldEmpty(_nameController.text.isEmpty);
    });

    _numberController.addListener(() { 
      fieldProvider.getIsNumberFieldEmpty(_numberController.text.isEmpty);
    });

    nameFocus.unfocus();
    numberFocus.requestFocus();

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    fieldProvider = Provider.of<FieldProvider>(context);
    return GestureDetector(
      onTap: () {
        clear();
        fieldProvider.setFieldState(0);
        Navigator.of(context).pop();
      },
      child: AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        backgroundColor: ProjectColors.transparent,
        elevation: 0,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: IndexedStack(
            index: fieldProvider.fieldState,
            children: [
              phoneState(),
              nameState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneState() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    null;
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.5),Colors.blue.withOpacity(0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),borderRadius: BorderRadius.circular(12)),padding: const EdgeInsets.all(2),
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 30, 30, 30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Phone number: ', style: TextStyle(color: ProjectColors.customColor, fontSize: 22)),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  focusNode: numberFocus,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  controller: _numberController,
                                  style: const TextStyle(color: Colors.white, fontSize: 24),
                                  decoration: inputDecoration(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Space.sHeight,
                GestureDetector(
                  onTap: () {
                    if(_numberController.text.isEmpty) return;
                    numberFocus.unfocus();
                    nameFocus.requestFocus();
                    fieldProvider.setFieldState(1);
                  },
                  child: button('CONTINUE', fieldProvider.isNumberFieldEmpty),
                ),
              ],
            );
  }

  Widget nameState() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    null;
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.5),Colors.blue.withOpacity(0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),borderRadius: BorderRadius.circular(12)),padding: const EdgeInsets.all(2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 30, 30, 30)),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name: ', style: TextStyle(color: ProjectColors.themeColorMOD2, fontSize: 24)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  style: TextStyle(color: ProjectColors.customColor, fontSize: 24),
                                  focusNode: nameFocus,
                                  controller: _nameController,
                                  decoration: inputDecoration(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Space.sHeight,
                GestureDetector(
                  onTap: () {
                    if(_nameController.text.isEmpty) return;
                    nameFocus.unfocus();
                    fieldProvider.setFieldState(0);
                    showDialog(context: context, builder: (context) => const Loading());
                    dbService.addContactToDatabase(FirebaseAuth.instance.currentUser!.uid, _numberController.text, _nameController.text).whenComplete(() => Navigator.of(context).popUntil((route) => route.isFirst)).catchError((error){
                      Utils.showSnackBar(error.toString());
                    });
                  },
                  child: button('ADD',fieldProvider.isNameFieldEmpty),
                ),
              ],
            );
  }

  Container button(String text, isEmpty) {
    return Container(
                width: SizeConfig.screenWidth,
                constraints: const BoxConstraints(maxWidth: 500),
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: ProjectColors.themeColorMOD3,
                  borderRadius: BorderRadius.circular(12), 
                  border: Border.all(color: isEmpty ? ProjectColors.greyColor : ProjectColors.customColor, width: 2)),
                child: Center(
                  child: ProjectText.rText(
                    text: text,
                    fontSize: 24,
                    color: isEmpty ? ProjectColors.greyColor : ProjectColors.customColor, fontWeight: FontWeight.bold)),
              );
  }

  InputDecoration inputDecoration(){
    return InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        isDense: true,
        hintStyle: TextStyle(color: ProjectColors.greyColor, fontSize: 14),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
    );
}
  clear(){
    _nameController.clear();
    _numberController.clear();
  }
}
