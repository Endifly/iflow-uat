import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:ios_d1/components/customWidgets/HeadsetConnector.dart';
import 'package:ios_d1/components/customWidgets/OrangeButton.dart';
import 'package:ios_d1/components/customWidgets/Typography.dart';

class HeadsetRSSI extends StatefulWidget {
  final HeadsetService headsetService;

  HeadsetRSSI({required this.headsetService});

  @override
  State<StatefulWidget> createState() {
    return _HeadsetRSSIState();
  }
}

class _HeadsetRSSIState extends State<HeadsetRSSI> {

  int signalStr = 0; // 0,1,2
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void startScan() async {
    print("### start scan");
    await flutterBlue.startScan(timeout: Duration(seconds: 2));
    List<BluetoothDevice> devicesTmp = [];
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name !=  "") {
          print("found :${r.device.name} with RSSI : ${r.rssi}");
          devicesTmp.add(r.device);
        }
      }
    });
    print("stop scan");
    await flutterBlue.stopScan();
  }

  void listenRSSI() async {
    flutterBlue.connectedDevices.then((devices) => {
      devices.forEach((d) {
        print(d.rssi)
      })
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    startScan();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          CTypo(text: "RSSI",),
          OrangeButton(title: "reload",onPress: ()=>startScan(),)
        ],
      ),
    );
  }
}