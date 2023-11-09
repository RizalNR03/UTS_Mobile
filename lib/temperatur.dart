import 'package:flutter/material.dart';

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  TextEditingController _controller = TextEditingController();
  late double input;
  late double output;
  late bool fOrC;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(_controller.text);
        } catch (e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText: "Masukan Suhu di ${fOrC ? "Celsius" : "Fahrenheit"}",
      ),
      textAlign: TextAlign.center,
    );

    AppBar appBar = AppBar(
      title: Text("Temperature Calculator"),
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Fahrenheit"),
          Radio<bool?>(
            groupValue: fOrC,
            value: false,
            onChanged: (bool? v) {
              setState(() {
                fOrC = v!;
              });
            },
          ),
          Text("Celsius"),
          Radio<bool?>(
            groupValue: fOrC,
            value: true,
            onChanged: (bool? v) {
              setState(() {
                fOrC = v!;
              });
            },
          ),
        ],
      ),
    );

    Container calcBtn = Container(
      child: ElevatedButton(
        child: Text("Calculate"),
        onPressed: () {
          setState(() {
            if (fOrC) {
              output = (input * 9 / 5) + 32;
            } else {
              output = (input - 32) * (5 / 9);
            }
          });
          AlertDialog dialog = AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                fOrC
                    ? Text(
                        "${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F")
                    : Text(
                        "${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C"),
                SizedBox(height: 10),
                Text("Reamur: ${(output * 4 / 5).toStringAsFixed(2)} R"),
                Text("Kelvin: ${(output + 273.15).toStringAsFixed(2)} K"),
              ],
            ),
          );
          showDialog(
              context: context, builder: (BuildContext context) => dialog);
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            inputField,
            tempSwitch,
            SizedBox(height: 20),
            calcBtn,
          ],
        ),
      ),
    );
  }
}
