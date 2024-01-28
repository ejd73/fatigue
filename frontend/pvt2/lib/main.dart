import 'package:flutter/material.dart';

void main() {
  runApp(PVTApp());
}

class PVTApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Psychomotor Vigilance Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PVTScreen(),
    );
  }
}

class PVTScreen extends StatefulWidget {
  @override
  _PVTScreenState createState() => _PVTScreenState();
}

class _PVTScreenState extends State<PVTScreen> {
  bool _buttonVisible = true;
  DateTime? _startTime;
  DateTime? _endTime;
  List<double> _reactionTimes = [];

  void _handleButtonPress() {
    if (!_buttonVisible) return;
    setState(() {
      _buttonVisible = false;
      _startTime = DateTime.now();
    });
  }

  void _handleButtonRelease() {
    if (_buttonVisible) return;
    setState(() {
      _endTime = DateTime.now();
      double reactionTime =
          _endTime!.difference(_startTime!).inMilliseconds / 1000.0;
      _reactionTimes.add(reactionTime);
      _startTime = null; // Reset start time for next trial
      _buttonVisible = true;
    });
  }

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psychomotor Vigilance Task'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF02082C), Color(0xFF0E3FA9)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text(
                'The PVT (psychomotor vigilance task) is a computer based test to measure alertness through your reaction time to visual cues. To begin the test, please tap once on the start button to start the timer, and quickly press it again to end the timer. (This is a simplified version of a more complicated test for demonstration purposes.)',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_buttonVisible)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: _handleButtonPress,
                        child: Text(
                          'Start Timer',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    else
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: _handleButtonRelease,
                          child: Text(
                            'Stop Timer',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                    Text(
                      _reactionTimes.isEmpty
                          ? 'Reaction Time: N/A'
                          : 'Reaction Time: ${_reactionTimes.last.toStringAsFixed(2)} seconds',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: _navigateToNextScreen,
                      child: Text(
                        'Go to Next Screen',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text(
          'This is the next screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
