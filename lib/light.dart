import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightSwitch1 extends StatefulWidget {
  const LightSwitch1({Key? key}) : super(key: key);

  @override
  State<LightSwitch1> createState() => _LightSwitch1State();
}

class _LightSwitch1State extends State<LightSwitch1> {
  double containerHeight = 0;
  double stickHeight = 120;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: LightClipper(size.height),
              child: AnimatedContainer(
                curve: Curves.bounceOut,
                duration: const Duration(milliseconds: 200),
                color: bgColor,
                height: containerHeight,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 105,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceOut,
                  width: 3,
                  height: stickHeight,
                  color: containerHeight == 0 ? Colors.white : Colors.black,
                ),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    //print(details.delta.dy);
                    setState(() {
                      stickHeight += details.delta.dy;
                    });
                  },
                  onVerticalDragEnd: (details) {
                    //print('end');
                    if (stickHeight <= 200) {
                      setState(() {
                        containerHeight = 0;
                        stickHeight = 120;
                      });
                    } else {
                      setState(() {
                        containerHeight = size.height;
                        stickHeight = 250;
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor:
                        containerHeight == 0 ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: containerHeight == 0
                              ? Colors.white.withOpacity(0.4)
                              : Colors.black,
                          width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: TextFormField(
                        style: GoogleFonts.pressStart2p(
                          fontWeight: FontWeight.w100,
                          color: containerHeight == 0
                              ? Colors.white
                              : Colors.black,
                          fontSize: 13,
                        ),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusColor: containerHeight == 0
                              ? Colors.white
                              : Colors.black,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          if (!value!.contains('@')) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: containerHeight == 0
                          ? Colors.white.withOpacity(0.4)
                          : Colors.black,
                      width: 3),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: TextFormField(
                      style: GoogleFonts.pressStart2p(
                        fontWeight: FontWeight.w100,
                        color:
                            containerHeight == 0 ? Colors.white : Colors.black,
                        fontSize: 13,
                      ),
                      controller: _passwordController,
                      obscureText: containerHeight == 0 ? true : false,
                      decoration: InputDecoration(
                        focusColor:
                            containerHeight == 0 ? Colors.white : Colors.black,
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                containerHeight == 0 ? "Login" : "Login",
                style: GoogleFonts.pressStart2p(
                    color: containerHeight == 0 ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path> {
  final double screenHeight;
  LightClipper(this.screenHeight);

  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;

    double control = height >= screenHeight * 0.95 ? 0 : 40;

    final path = Path();

    path.lineTo(0, control);
    path.relativeQuadraticBezierTo(width / 2, -control, width, 0);
    path.relativeLineTo(0, height - control);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Color bgColor = const Color(0xFFFECE02);
