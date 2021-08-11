import 'package:flutter/cupertino.dart';
import 'package:ios_d1/components/customClass/AnimationQueue.dart';
import 'package:ios_d1/components/customWidgets/ArcLoader/GradientArcPainter.dart';

class ArcLoaderController {
  void Function(double? val)? addProgress;
  void Function(int? ms)? setProgressSpeed;
}

class ArcLoader extends StatefulWidget {
  final double? value;
  final double? strokeWidth;
  final ArcLoaderController? controller;

  ArcLoader({this.value,this.strokeWidth,this.controller});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ArcLoaderState();
  }

}

class _ArcLoaderState extends State<ArcLoader> with TickerProviderStateMixin {

  double loadingValue = 0.0;
  double startPosition = 0.0;
  double? prevVal = null;
  double? currentVal = null;

  int progressAnimationSpeed = 1000;
  Animation<double>? progressAnimation;
  AnimationController? progressController;

  int startPositionAnimationSpeed = 1000;
  Animation<double>? startPositionAnimation;
  AnimationController? startPositionController;

  var endPositionQueue = AnimationQueue(from: 0.0, to: 0.0);
  var startPositionQueue = AnimationQueue(from: 0.0, to: 0.0);

  void setLoaderSpeed(int? val) {
    if (val != null) {
      setState(() {
        this.startPositionAnimationSpeed = val;
        this.progressAnimationSpeed = val;
      });
    }
  }

  void handleResetLoadingProgress(double val) {
    print("### reset progress");
    startPositionController!.stop();
    progressController!.stop();

    if (val > loadingValue) {
      print("val more than loading");
      endPositionQueue.from = loadingValue;
      endPositionQueue.to = val;
    }

    if (val < loadingValue) {
      print("val less than loading");
      endPositionQueue.from = val;
      endPositionQueue.to = 0.0;

      progressController = AnimationController(duration: Duration(milliseconds: progressAnimationSpeed), vsync: this);
      progressAnimation = Tween(begin: endPositionQueue.from,end:endPositionQueue.to).animate(
          new CurvedAnimation(parent: progressController!, curve: Curves.easeInOut)
      );
      progressController!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          endPositionQueue.add(0.0);
          nextProgress(val);
        }
      });
      progressAnimation!.addListener(() {
        setState(() {
          loadingValue = progressAnimation!.value;
        });
      });
    }


    nextProgress(val);
  }

  void handleLoadingProgress() {
    // startPositionAnimationSpeed = 1;

    try {
      startPositionController!.dispose();
      progressController!.dispose();
    } catch(_) {

    }

    startPositionQueue.from = 0.0;
    startPositionQueue.to = 1.0;

    endPositionQueue.from = 0.0;
    endPositionQueue.to = 1.0;

    startPositionController = AnimationController(duration: Duration(milliseconds: startPositionAnimationSpeed), vsync: this);
    startPositionAnimation = Tween(begin: startPositionQueue.from,end:startPositionQueue.to).animate(
        new CurvedAnimation(parent: startPositionController!, curve: Curves.easeInOut)
    );
    startPositionAnimation!.addListener(() {
      setState(() {
        startPosition = startPositionAnimation!.value;
      });
    });

    progressController = AnimationController(duration: Duration(milliseconds: progressAnimationSpeed), vsync: this);
    progressAnimation = Tween(begin: endPositionQueue.from,end:endPositionQueue.to).animate(
        new CurvedAnimation(parent: progressController!, curve: Curves.easeInOut)
    );
    progressAnimation!.addListener(() {
      setState(() {
        loadingValue = progressAnimation!.value;
      });
    });

    progressController!.addStatusListener((status) {
      print("### end position controller status : ${status}");
      if (status == AnimationStatus.forward) {
        if (currentVal != null) {
          startPositionQueue.add(0.0);
          endPositionQueue.add(0.0);
          startPositionController!.dispose();
          progressController!.dispose();
          nextProgress(currentVal!);
        }
      }
    });

    if (currentVal == null) {
      startPositionController!.repeat(reverse: false);
      progressController!.repeat(reverse: true);
    }

  }

  void nextProgress(double val) {
    print("### next progress");
    // startPositionController!.reset();
    // progressController!.reset();
    endPositionQueue.add(val);
    // if (endPositionQueue.from > 0.0) {
    //   endPositionQueue.from = 0.0;
    //   endPositionQueue.to = (val);
    // }

    progressController = AnimationController(duration: Duration(milliseconds: progressAnimationSpeed), vsync: this);
    progressAnimation = Tween(begin: endPositionQueue.from,end:endPositionQueue.to).animate(
        new CurvedAnimation(parent: progressController!, curve: Curves.easeInOut)
    );
    progressAnimation!.addListener(() {
      setState(() {
        loadingValue = progressAnimation!.value;
      });
    });
    progressController!.forward();
  }

  void addProgress(double? val) {
    print("### sec arc loader : ${val}");
    currentVal = val;
    // if (val == null) {
    //   prevVal = val;
    //   return handleLoadingProgress();
    // }
    if (val == null) {
      handleLoadingProgress();
    }

    if (prevVal != null && val != null) {
      nextProgress(val);
    }

    prevVal = val;

    // if (prevVal == null) {
    //   prevVal = val;
    //   return handleResetLoadingProgress(val);
    // }

    // endPositionQueue.from = loadingValue;
    // endPositionQueue.to = val;
    //
    // startPositionController!.reset();
    // progressController!.reset();
    // if (endPositionQueue.from > 0.0) {
    //   endPositionQueue.from = 0.0;
    //   endPositionQueue.to = (val);
    // }
    //
    // progressController = AnimationController(duration: Duration(milliseconds: progressAnimationSpeed), vsync: this);
    // progressAnimation = Tween(begin: endPositionQueue.from,end:endPositionQueue.to).animate(
    //     new CurvedAnimation(parent: progressController!, curve: Curves.easeInOut)
    // );
    // progressAnimation!.addListener(() {
    //   setState(() {
    //     loadingValue = progressAnimation!.value;
    //   });
    // });
    // progressController!.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.handleLoadingProgress();
    widget.controller?.addProgress = addProgress;
    widget.controller?.setProgressSpeed = setLoaderSpeed;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    progressController!.stop();
    startPositionController!.stop();

    progressController!.dispose();
    startPositionController!.dispose();

    super.dispose();

    progressController!.stop();
    startPositionController!.stop();
  }

  @override
  Widget build(BuildContext context) {

    double progressValue() {
      if (this.loadingValue == null) return 0.0;
      if (widget.value == null) return this.loadingValue;
      return widget.value!;
    }

    // print("startValue : ${startPosition}, loadingValue : ${loadingValue},");

    // TODO: implement build
    return Container(
      child:
        CustomPaint(
            painter: GradientArcPainter(
              startPosition: startPosition,
              width: widget.strokeWidth ?? 4,
              endColor: Color.fromRGBO(242,149,50, 1),
              startColor: Color.fromRGBO(254,199,79, 1).withAlpha(100),
              progress: progressValue()
            ),
    ),
    );
  }

}