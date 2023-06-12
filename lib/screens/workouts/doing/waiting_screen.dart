import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_gym_book/widgets/wave_background_widget.dart';

class WaitingScreen extends StatefulWidget {
  final int duration;

  WaitingScreen({Key? key, required this.duration}) : super(key: key);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  late Timer _timer;
  int _tempoRestante = 0;
  bool _pausado = false;

  @override
  void initState() {
    super.initState();
    _tempoRestante = widget.duration;
    _iniciarTimer();
  }

  void _iniciarTimer() {
    setState(() {
      _pausado = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_tempoRestante > 0) {
          _tempoRestante--;
        } else {
          _pausado = true;
          _timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  void _pausarTimer() {
    setState(() {
      _pausado = true;
    });

    _timer.cancel();
  }

  void _adicionarTempo() {
    setState(() {
      _tempoRestante += 15;
    });
  }

  void _subtrairTempo() {
    setState(() {
      if (_tempoRestante > 15) {
        _tempoRestante -= 15;
      } else {
        _tempoRestante = 0;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descanse e relaxa'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _pausado ? _iniciarTimer : _pausarTimer,
              icon: Icon(_pausado ? Icons.play_arrow : Icons.pause)
          ),
        ],
      ),
      body: Stack(
        children: [
          const WaveBackgroundWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _subtrairTempo,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('-', style: TextStyle(fontSize: 50),),
                        Text('15s'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_tempoRestante',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text(
                        'segundos',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _adicionarTempo,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('+', style: TextStyle(fontSize: 50),),
                        Text('15s'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]
      ),
    );
  }
}
