import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/contexts/kColors.dart';

class ProfileImage extends StatelessWidget {
  final String imagePath;
  DecorationImage? avatar;
  ProfileImage({required this.imagePath}) {
    // print("${this.imagePath}, ${imagePath}");
    if (this.imagePath.startsWith('https')) {
      avatar = DecorationImage(image: NetworkImage(this.imagePath));
    }
    else {
      avatar = DecorationImage(image : AssetImage("assets/images/person_2.png"));
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: [
          FractionalTranslation(
              translation: Offset(0,0),
              child: Transform.scale(
                scale: 0.75,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color : kColors.black[100],
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ),
          FractionalTranslation(
              translation: Offset(0,0),
              child: Transform.scale(
                scale: 0.7,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    image: avatar,
                    color : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}