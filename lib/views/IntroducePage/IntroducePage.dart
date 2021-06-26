import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/components/customWidgets/WhiteButton.dart';
import '/views/IntroducePage/Headset.dart';
import '/views/IntroducePage/Introduce2.dart';
import '/views/IntroducePage/WhyIflow.dart';

class IntroducePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroducePageState();
  }
}

class _IntroducePageState extends State<IntroducePage> {

  CarouselController buttonCarouselController = CarouselController();
  int pageNumber = 0;
  List<Widget> introDuceSlide = [WhyIflow(),Introduce2(),HeadsetIntroduce()];

  void toAuth() {
    Navigator.pushNamed(context, '/select-auth');
  }

  void onChangePage(int pageIndex) {
    setState(() {
      pageNumber = pageIndex;
    });
  }

  void nextSlide() {
    if (pageNumber >= introDuceSlide.length-1) {
      toAuth();
      return ;
    }
    pageNumber++;
    // buttonCarouselController.nextPage(duration: Duration(milliseconds: 300),curve: Curves.linear);
    buttonCarouselController.animateToPage(pageNumber,duration: Duration(milliseconds: 300),curve: Curves.linear);
  }

  Widget slider() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: WhyIflow(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Introduce2(),
            ),
          ],
        ),
      ),
    );
  }

  Widget Carousel() {
    if (buttonCarouselController == null) return Container();
    else return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
          height: MediaQuery.of(context).size.height*0.8,
          initialPage: 0,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          onPageChanged: (index,reason)=>onChangePage(index)
      ),
      items: introDuceSlide.map((widget) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: widget,
            );
          },
        );
      }).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // slider(),
            Carousel(),
            // SizedBox(height: 16,),
            DotIndicator(count: 3,index: pageNumber,),
            SizedBox(height: 24,),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: WhiteButton(title: "ถัดไป",onPress: nextSlide,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget{

  final int count;
  final int index;

  DotIndicator({required this.count,required this.index});

  Widget Dot(int _index) {
    return Container(
      width: 12,
      height: 12,
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        color: _index == index ? Colors.grey : Color.fromRGBO(0, 0, 0, 0),
        shape: BoxShape.circle,
      ),
    );
  }

  List<Widget> Dots() {
    List<Widget> dots = [];
    for (var i=0; i<count ; i++) {
      dots.add(Dot(i));
    }
    return dots.toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Dots(),
      ),
    );
  }

}