import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/details.dart';
import 'package:weloggerweb/services/firestore.dart';

class ContactCard extends StatefulWidget {
  final bool isHomePage;
  const ContactCard({Key? key, required this.isHomePage}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('webcontacts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (auth.currentUser == null) {
            return CircularProgressIndicator(color: ProjectColors.customColor);
          } else {
            if (snapshot.hasData) {
              final doc = snapshot.data!.docs.where((element) => element.get('users').keys.contains(auth.currentUser!.uid));
              return Column(
                  children: doc.map((document) {
                String name = document['users'][auth.currentUser!.uid]['name'];
                String documentId = document['document_id'];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(number: documentId))),
                  child: Container(
                    height: Values.contactCardHeight,
                    width: SizeConfig.isDesktop!
                        ? SizeConfig.screenWidth! - Values.desktopMenuWidth
                        : SizeConfig.screenWidth,
                    padding: ProjectPadding.horizontalPadding(value: 20),
                    margin: EdgeInsets.symmetric(horizontal: widget.isHomePage ? 0 : 20) + const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: ProjectColors.transparent,
                        borderRadius: BorderRadius.circular(
                            widget.isHomePage ? Values.contactCardRadius : Values.contactCardRadius / 2),
                        border: Border.all(color: ProjectColors.greyColor, width: 1)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(
                        children: [
                          Image(image: ImageEnums.denemepersonicon.assetImage, color: ProjectColors.themeColorMOD2, width: 50, height: 50),
                          Space.sWidth,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProjectText.rText(
                                  text: name,
                                  fontSize: Values.fitValue,
                                  color: ProjectColors.customColor,
                                  fontWeight: FontWeight.bold),
                              Space.xXSWidth,
                              ProjectText.rText(text: documentId, fontSize: Values.sValue, color: ProjectColors.greyColor)
                            ],
                          )
                        ],
                      ),
                      widget.isHomePage
                          ? GestureDetector(
                              onTap: () {
                                showDialog(context: context, builder: (context) => const Loading());
                                DbService().deleteContactFromDatabase(FirebaseAuth.instance.currentUser!.uid, document.id).whenComplete(() => Navigator.of(context).popUntil((route) => route.isFirst));
                              },
                              child: Icon(Icons.delete, color: ProjectColors.offlineColor, size: Values.deleteIconSize))
                          : ProjectText.rText(text: 'Online', fontSize: Values.fitValue, color: ProjectColors.onlineColor)
                    ]),
                  ),
                );
              }).toList());
            } else {
              return Space.emptySpace;
            }
          }
        });
  }
}
