import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';

class Details extends StatefulWidget {
  final String number;
  const Details({Key? key, required this.number}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            const WebBar(),
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - Values.barHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizeConfig.isDesktop!
                    ? Row(children: [
                        const DesktopMenu(),
                        SizedBox(
                          width: SizeConfig.screenWidth! - Values.desktopMenuWidth,
                          height: SizeConfig.screenHeight! - Values.barHeight,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             contactCard(),
                             const DateWidget(),
                             DetailsCard(number: widget.number),
                             LogCard(number: widget.number)
                          ]),
                        ), 
                      ],)
                    : Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            contactCard(),
                            const DateWidget(),
                            DetailsCard(number: widget.number),
                            LogCard(number: widget.number)
                        ]),
                        const MobileMenu()
                      ],
                    ), 
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget contactCard(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('webcontacts').doc(widget.number).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot){

        // DateTime? lastSeen;

        // final String name = snapshot.data!.get('users')[FirebaseAuth.instance.currentUser!.uid]['name'];
        // final bool? isOnline = snapshot.data!.get('is_online');
        // final Timestamp? lastSeenTimestamp = snapshot.data!.get('last_seen');
        // if(lastSeenTimestamp != null) lastSeen = DateTime.parse(formattedDate(lastSeenTimestamp));

        DateTime lastSeen = DateTime.now();
        bool isOnline= false;
        String name = 'asd';
        
        //if(snapshot.connectionState == ConnectionState.waiting) return const Loading();
        if(snapshot.hasData){
          return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
          height: 80,
          decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: ProjectColors.greyColor, width: 1), borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(image: ImageEnums.denemepersonicon.assetImage, color: ProjectColors.themeColorMOD2, width: 50, height: 50),
                  Space.sWidth,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProjectText.rText(text: name, fontSize: 18, color: ProjectColors.customColor),
                      Space.xSWidth,
                      ProjectText.rText(text: widget.number, fontSize: 14, color: ProjectColors.greyColor),
                    ],
                  )
                ],
              ),
              isOnline == null ? ProjectText.rText(text: 'No Data', fontSize: 20) : isOnline ? onlineState : offlineState(lastSeen)
            ],
          ),
        );
        }else{
          return const Loading();
        }
      },
    );
  }

  Column offlineState(DateTime lastSeen) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectText.rText(text: 'Last Seen', fontSize: 16, color: ProjectColors.onlineColor),
                Space.xSWidth,
                ProjectText.rText(text: DateFormat().add_MEd().format(lastSeen), fontSize: 14, color: ProjectColors.greyColor),
              ],
            );
  }

  Widget get onlineState => ProjectText.rText(text: 'Online', fontSize: 16, color: ProjectColors.onlineColor);

}



        