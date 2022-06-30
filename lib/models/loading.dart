import 'package:flutter/material.dart';
import 'package:weloggerweb/products/products.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({Key? key, this.color = Colors.orange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(color: ProjectColors.opacityDEFw(0.1), borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logging in..',
              style: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontSize: 20),
            ),
            Space.sWidth,
            const CircularProgressIndicator(color: Color.fromARGB(255, 220, 220, 220))
          ],
        ),
      ),
    );
  }
}

class LoadingScreenWithDuration extends StatefulWidget {
  final Widget route;
  const LoadingScreenWithDuration({Key? key, required this.route}) : super(key: key);

  @override
  State<LoadingScreenWithDuration> createState() => _LoadingScreenWithDurationState();
}

class _LoadingScreenWithDurationState extends State<LoadingScreenWithDuration> {
  bool isLoad = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      isLoad = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 220, 220, 220)))
        : widget.route;
  }
}
