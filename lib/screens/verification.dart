// import 'package:flutter/material.dart';
// import 'package:weloggerweb/models/models.dart';
// import 'package:weloggerweb/products/products.dart';

// class Verification extends StatelessWidget {
//   const Verification({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     SizeConfig.getDevice();
//     return Scaffold(
//       body: SizedBox(
//         height: SizeConfig.screenHeight,
//         width: SizeConfig.screenWidth,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const WebBar(),
//             SizeConfig.isDesktop!
//                 ? Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       DesktopMenu(),
//                       VerificationPage(),
//                     ],
//                   )
//                 : Stack(
//                     children: const [VerificationPage(), MobileMenu()],
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
