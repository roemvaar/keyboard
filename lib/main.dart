import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterMidi = FlutterMidi();
  @override
  void initState() {
    if (!kIsWeb) {
      load(_value);
    } else {
      _flutterMidi.prepare(sf2: null);
    }
    super.initState();
  }

  void load(String asset) async {
    print('Loading File...');
    _flutterMidi.unmute();
    ByteData byte = await rootBundle.load(asset);
    _flutterMidi.prepare(sf2: byte, name: _value.replaceAll('assets/', ''));
  }

  String _value = 'assets/Piano.sf2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Piano Keyboard'),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Play C'),
              onPressed: () {
                _play(60);
              },
            ),
            ElevatedButton(
              child: Text('Play D'),
              onPressed: () {
                _play(60);
              },
            ),
            ElevatedButton(
              child: Text('Play E'),
              onPressed: () {
                _play(60);
              },
            ),
          ],
        )),
      ),
    );
  }

  void _play(int midi) {
    if (kIsWeb) {
      // WebMidi.play(midi);
    } else {
      _flutterMidi.playMidiNote(midi: midi);
    }
  }
}
