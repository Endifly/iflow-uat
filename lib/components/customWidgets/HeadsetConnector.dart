import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

// class MyCharacteristic {
//   final Guid uuid;
//   // final List<int> value;
//   final BluetoothCharacteristic char;
//   MyCharacteristic({this.uuid,this.char});
// }
typedef void onConnectedCallback(HeadsetService headsetService);

class HeadsetCharacteristic {
  final String name;
  final Guid uuid;
  final BluetoothCharacteristic characteristic;
  HeadsetCharacteristic({required this.name,required this.uuid,required this.characteristic});
}

class HeadsetService {
  BluetoothDevice device ;
  List<BluetoothCharacteristic> eeg = [];
  List<BluetoothCharacteristic> cmd = [];

  Guid SERVICE_EEG = Guid("FDAF0100-5009-4b18-9ff8-1ea4945d84cb");
  Guid SIGNAL_QUALITY = Guid("FDAF0101-5009-4b18-9ff8-1ea4945d84cb");
  Guid EEG_OUTPUT = Guid("FDAF0102-5009-4b18-9ff8-1ea4945d84cb");
  Guid EEG_ATTENTION = Guid("FDAF0103-5009-4b18-9ff8-1ea4945d84cb");
  Guid EEG_MEDITATION = Guid("FDAF0104-5009-4b18-9ff8-1ea4945d84cb");
  Guid EEG_MODE = Guid("FDAF0105-5009-4b18-9ff8-1ea4945d84cb");

  Guid SERVICE_CMD = Guid("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
  Guid CMD_TX = Guid("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");
  Guid CMD_RX = Guid("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");

  HeadsetService({required this.cmd,required this.eeg,required this.device});

  BluetoothCharacteristic? getEegChar(Guid uuid) {
    for (BluetoothCharacteristic c in eeg) {
      if (c.uuid == uuid) return c;
    }
  }

  BluetoothCharacteristic? getTxChar() {
    for (BluetoothCharacteristic c in cmd) {
      if (c.uuid == this.CMD_TX) return c;
    }
  }

  BluetoothCharacteristic? getRxChar() {
    for (BluetoothCharacteristic c in cmd) {
      if (c.uuid == this.CMD_RX) return c;
    }
  }


  Future<List<int>> readCharacteristic(BluetoothCharacteristic c) async {
    List<int> value = await c.read();
    return value;
  }

  void writeCharacteristic(BluetoothCharacteristic char,List<int> values) async {
    print("write value ${values}");
    await char.write(values);
  }

  void writeRx(List<int> values) async {
    BluetoothCharacteristic? Rx = getRxChar();
    if (Rx != null) writeCharacteristic(Rx,values);
  }

  void useCalibration() async {
    try {
      writeRx([74,183,62]);
    } catch(e) {
      print("write error");
    }
  }

  void useMindWandering() async {
    try {
      writeRx([74,183,62]);
    } catch(e) {
      print("write error");
    }
  }

  Future<List<int>> readTx() async {
    print("reading rx ...");
    var values = await readCharacteristic(getTxChar()!);
    print("rx value : ${values}");
    return values;
  }


  Future<List<int>> readEEG(Guid uuid) async {
    var values = readCharacteristic(getEegChar(uuid)!);
    return values;
  }

  Future<List<int>> readSignalQuality() async {
    return readEEG(this.SIGNAL_QUALITY);
  }

  Future<List<int>> readAttention() async {
    return readEEG(this.EEG_ATTENTION);
  }

  Future<List<int>> readMeditation() async {
    return readEEG(this.EEG_MEDITATION);
  }
}

Guid SERVICE_EEG = Guid("FDAF0100-5009-4b18-9ff8-1ea4945d84cb");
Guid SIGNAL_QUALITY = Guid("FDAF0101-5009-4b18-9ff8-1ea4945d84cb");
Guid EEG_OUTPUT = Guid("FDAF0102-5009-4b18-9ff8-1ea4945d84cb");
Guid EEG_ATTENTION = Guid("FDAF0103-5009-4b18-9ff8-1ea4945d84cb");
Guid EEG_MEDITATION = Guid("FDAF0104-5009-4b18-9ff8-1ea4945d84cb");
Guid EEG_MODE = Guid("FDAF0105-5009-4b18-9ff8-1ea4945d84cb");

Guid SERVICE_CMD = Guid("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
Guid CMD_TX = Guid("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");
Guid CMD_RX = Guid("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");

class HeadsetConnector extends StatefulWidget {

  final onConnectedCallback? onConnected;

  HeadsetConnector({this.onConnected});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HeadsetConnectorState();
  }

}

const HEADSET_DEFAULT_STATE = 0;
const HEADSET_FINDING_STATE = 1;
const HEADSET_FOUND_DEVICE_STATE = 2;
const HEADSET_TOO_MANY_DEVICE_STATE = 3;
const HEADSET_DEVICE_NOT_FOUND_STATE = 4;
const HEADSET_WAIT_FOR_EQUIP_STATE = 5;
const HEADSET_TUNING_STATE = 6;
const HEADSET_READY_STATE = 7;

class _HeadsetConnectorState extends State<HeadsetConnector> {
  int connectionState = HEADSET_DEFAULT_STATE; //default , finding, found device, too many devices ,not found, wait for equip, tuning, ready
  var loadingValue = null;

  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  List<BluetoothService> services = [];
  BluetoothService? selectedService;
  HeadsetService? headsetService;
  Timer? updater;
  Timer? timeout;

  var isCalibrated = false;

  void onLoadSuccess() {
    updater!.cancel();
    timeout!.cancel();
    stopUpdater();
    setState(() {
      connectionState = HEADSET_READY_STATE;
      loadingValue = 100.0;
    });
  }

  // void checkSignalQuality(int signalQuality) {
  //   if (signalQuality == 0) {
  //     if (!isCalibrated) {
  //       print("### use calibrate");
  //       headsetService.useCalibration();
  //       setState(() {
  //         isCalibrated = true;
  //       });
  //     }
  //     setState(() {
  //       connectionState = HEADSET_TUNING_STATE;
  //     });
  //     print("##timeout : ${timeout}");
  //     if (timeout == null) {
  //       print("## start timeout");
  //       timeout = Timer(Duration(seconds: 10),() {
  //         print("### timeout");
  //         setState(() {
  //           connectionState = HEADSET_READY_STATE;
  //         });
  //         updater.cancel();
  //         timeout.cancel();
  //         onLoadSuccess();
  //         widget.onConnected(headsetService);
  //         return;
  //       });
  //     }
  //   } else {
  //     timeout.cancel();
  //     timeout = null;
  //     setState(() {
  //       connectionState = HEADSET_WAIT_FOR_EQUIP_STATE;
  //     });
  //   }
  // }

  void checkSignalQuality(int signalQuality) {
    if (signalQuality == 0) {
      // if (!isCalibrated) {
      //   print("### use calibrate");
      //   headsetService.useCalibration();
      //   setState(() {
      //     isCalibrated = true;
      //   });
      // }
      setState(() {
        connectionState = HEADSET_TUNING_STATE;
      });
      
    } else {
      setState(() {
        connectionState = HEADSET_WAIT_FOR_EQUIP_STATE;
      });
    }
  }

  void setLoadingValue(double value) {
    print("loadingValue : ${value}");
    setState(() {
      loadingValue = value;
    });
  }

  void checkCalibration() async {
    var callibrations = await headsetService!.readTx();
    print("callibration : ${callibrations}");
    var callibration = callibrations[1];
    if (callibration >= 4) {
      setState(() {
        connectionState = HEADSET_READY_STATE;
      });
    }
    var loadingVal = min(((100/5)*(callibration+1))/100, 1.0);
    setLoadingValue(loadingVal);
  }
  
  void onUpdateHeadset() async {
    var signalQualitys = await headsetService!.readSignalQuality();
    var signalQuality = signalQualitys[0];
    print("Signal quality : ${signalQuality})");
    if (connectionState == HEADSET_WAIT_FOR_EQUIP_STATE) {
      checkSignalQuality(signalQuality);
    }
    if (connectionState == HEADSET_TUNING_STATE) {
      checkSignalQuality(signalQuality);
      headsetService!.useCalibration();
      Future.delayed(Duration(seconds: 2),checkCalibration);
    }
    if (connectionState == HEADSET_READY_STATE) {
      print("connect success : ${headsetService}");
      widget.onConnected!(headsetService!);
      onLoadSuccess();
    }
  }

  void startUpdater() {
    setState(() {
      updater = Timer.periodic(Duration(seconds: 5), (timer) {
        onUpdateHeadset();
      });
    });
  }

  void stopUpdater() {
    updater!.cancel();
  }

  List<BluetoothDevice> filterDevices(List<BluetoothDevice> devices) {
    List<BluetoothDevice> devicesTmp = [];
    for (BluetoothDevice d in devices) {
      if (d.name.contains("iFlow")) {
        devicesTmp.add(d);
      }
    }
    return devicesTmp;
  }

  Future<List<int>> readCharacteristic(BluetoothCharacteristic c) async {
    List<int> value = await c.read();
    return value;
  }

  Future<List<BluetoothCharacteristic>> getCharacteristic(BluetoothService service) async {
    if (service == null) return [];
    var characteristics = service.characteristics;
    return characteristics;
  }

  Future<void> getService(BluetoothDevice device) async {
    await device.connect();
    print("connected");
    List<BluetoothService> servicesTmp = [];
    List<BluetoothCharacteristic> eegChars = [];
    List<BluetoothCharacteristic> cmdChars = [];
    List<BluetoothService> _services = await device.discoverServices();
    //here await _services.forEach
    _services.forEach((service) async {
      if (service.uuid == SERVICE_EEG) {
        servicesTmp.add(service);
        var chars = await getCharacteristic(service);
        eegChars = chars;
      }
      if (service.uuid == SERVICE_CMD) {
        servicesTmp.add(service);
        var chars = await getCharacteristic(service);
        cmdChars = chars;
      }
    });
    HeadsetService _headsetService = HeadsetService(eeg: eegChars,cmd: cmdChars,device: selectedDevice!);
    print("found ${servicesTmp.length} services");
    print("headsetSerivce : ${_headsetService}");
    startUpdater();
    setState(() {
      headsetService = _headsetService;
      services = servicesTmp;
      connectionState = HEADSET_WAIT_FOR_EQUIP_STATE; //wait for equip
    });
  }

  void writeChar(BluetoothCharacteristic char,String value) async {
    List<String> valueSplit = value.split(" ");
    List<int> valueInt = valueSplit.map(int.parse).toList();
    print("write value ${valueInt}");
    await char.write(valueInt);
  }

  void setDevice(BluetoothDevice device) async {
    setState(() {
      selectedDevice = device;
    });
    await getService(device);
  }

  void disConnectDevice() {
    print("disconnect");
    selectedDevice!.disconnect();
    setState(() {
      selectedDevice = null;
      services = [];
      selectedService = null;
    });
  }

  void startScan() async {
    print("### start scan");
    setState(() {
      connectionState = HEADSET_FINDING_STATE;
      loadingValue = null;
    });
    await flutterBlue.startScan(timeout: Duration(seconds: 4));
    List<BluetoothDevice> devicesTmp = [];
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name !=  "") {
          devicesTmp.add(r.device);
        }
      }
    });

    await flutterBlue.stopScan();
    var targetDevices = filterDevices(devicesTmp);
    print("### stop scan found ${devicesTmp.length} devices and ${targetDevices.length} target devices");
    setState(() {
      devices = devicesTmp;
      if (targetDevices.length > 0) {
        if (targetDevices.length ==1) {
          connectionState = HEADSET_FOUND_DEVICE_STATE;
          setDevice(targetDevices[0]);
          // Future.delayed(Duration(seconds: 2),(){
          //   setState(() {
          //     connectionState = 5;
          //   });
          // });
        }
      } else {
        connectionState = HEADSET_DEVICE_NOT_FOUND_STATE;
        loadingValue=0.0;
      }
    });
  }

  String getLabel() {
    switch(connectionState) {
      case HEADSET_DEFAULT_STATE :
        return "เริ่มการเชื่อมต่อ";
      case HEADSET_FINDING_STATE :
        return "กำลังค้นหาอุปกรณ์";
      case HEADSET_FOUND_DEVICE_STATE :
        return "พบอุปกรณ์แล้ว";
      case HEADSET_TOO_MANY_DEVICE_STATE :
        return "พบอุปกรณ์หลายตัว";
      case HEADSET_DEVICE_NOT_FOUND_STATE :
        return "ไม่พบอุปกรณ์";
      case HEADSET_WAIT_FOR_EQUIP_STATE :
        return "สวมใส่เพื่อเริ่มใช้งาน";
      case HEADSET_TUNING_STATE :
        return "กำลัง calibrate";
      case HEADSET_READY_STATE :
        return "อุปกรณ์พร้อมแล้ว";
      default :
        return "เริ่มการเชื่อมต่อ";

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    startScan();
    super.initState();
  }

  @override
  void dispose() {
    updater!.cancel();
    timeout!.cancel();
    disConnectDevice();
    stopUpdater();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: startScan,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.7,
              // margin: EdgeInsets.all(48.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Color.fromRGBO(233, 234, 238, 1)
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        offset: Offset(6, 2),
                        blurRadius: 16.0,
                        spreadRadius: 4.0),
                    BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                        offset: Offset(-4, -4),
                        blurRadius: 6.0,
                        spreadRadius: 4.0)
                  ]),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.all(48.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(255, 234, 185, 1),
                    Color.fromRGBO(255, 247, 196, 1),
                    Color.fromRGBO(255, 243, 139, 1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.6 - 24,
              margin: EdgeInsets.all(48.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Column(
              children: [
                IconButton(onPressed: startScan,
                  icon: Icon(
                    Icons.bluetooth,
                    color: Colors.grey,
                    size: 42.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                Container(height: 16,),
                Text(getLabel(), style: TextStyle(fontSize: 18,color: Colors.grey),),
                // Text("อุปกรณ์", style: TextStyle(fontSize: 18,color: Colors.grey),),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.6 - 10,
              width: MediaQuery.of(context).size.width * 0.6 - 10,
              child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 204, 79, 0.8),
                strokeWidth: 12,
                value: loadingValue,
                // semanticsValue: "asd",
              ),
            ),
          ],
        ),
      ),
    );
  }

}