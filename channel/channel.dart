import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformChannel extends StatefulWidget {
  _PlatformChannelState createState() => _PlatformChannelState();
}

class _PlatformChannelState extends State<PlatformChannel> {
  // 通过key找到对应的method, 每个Channel在创建时必须指定一个独一无二的name, 被动模式
  static const MethodChannel methodChannel = MethodChannel('xuhang.channel/battry');
  // 主动模式，可以自动把值推送过来
  static const EventChannel eventChannel = EventChannel('xuhang.chanel/charging');

  String _batteryLevel = 'Battery level: unknown.';
  String _chargingStatus = 'Battery status: unknown.';

  // 使用async控制程序同步, --未来、前途
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try{
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    }on PlatformException{
      batteryLevel = 'Failed to get battery level.';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent,onError:_onError);
  }

  void _onEvent(Object event){
    setState(() {
      _chargingStatus = "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
    });
  }

  void _onError() {
    setState(() {
      _chargingStatus = 'Battery status: unknown.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_batteryLevel,key: const Key('Battery level label')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                    child: const Text('Refresh'),
                    onPressed: _getBatteryLevel,
                ),
              )
            ],
          ),
          Text(_chargingStatus)
        ],
      ),
    );
  }
}

void main(){
  runApp(MaterialApp(home: PlatformChannel()));
}