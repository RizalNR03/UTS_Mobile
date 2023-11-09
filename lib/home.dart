import 'package:flutter/material.dart';
import 'package:uts/bmi_calculator.dart';
import 'package:uts/curency.dart';
import 'package:uts/kalkulator.dart';
import 'package:uts/kalkulatorscientific.dart';
import 'package:uts/temperatur.dart';
import 'package:uts/profile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'login.dart';
import 'placeholder.dart';

class Home extends StatefulWidget {
  final String username;

  Home({required this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    CalculatorWidget(),
    ProfileScreen(),
  ];

  Future<bool> _onBackPressed(BuildContext context) async {
    bool isExitConfirmed = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((value) {
      isExitConfirmed = value ?? false;
    });
    return isExitConfirmed;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Hello, ${widget.username}'), // Menampilkan username di app bar
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _onBackPressed(context);
              },
            );
          },
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalculatorScreen()),
                  );
                },
                icon: Icon(Icons.calculate_outlined),
                label: Text('Kalkulator Sayur'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScientificCalculator(),
                    ),
                  );
                },
                icon: Icon(Icons.science),
                label: Text('Scientific'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TempApp()),
                  );
                },
                icon: Icon(Icons.thermostat_outlined),
                label: Text('Suhu'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BmiCalculationPage()),
                  );
                },
                icon: Icon(Icons.monitor_weight),
                label: Text('BMI'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CurrencyConverter()),
                  );
                },
                icon: Icon(Icons.attach_money),
                label: Text('Konversi Mata Uang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
