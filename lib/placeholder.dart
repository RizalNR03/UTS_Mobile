import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlaceholderWidget extends StatefulWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  List<charts.Series<LinearNilai, String>> _createSampleData(
      List<LinearNilai> data) {
    return [
      charts.Series<LinearNilai, String>(
        id: 'Nilai',
        domainFn: (LinearNilai Nilai, _) => Nilai.hari,
        measureFn: (LinearNilai Nilai, _) => Nilai.Nilai,
        data: data,
      )
    ];
  }

  List<LinearNilai> _data = [
    LinearNilai('Mon', 5),
    LinearNilai('Tue', 25),
    LinearNilai('Wed', 100),
    LinearNilai('Thu', 75),
  ];

  TextEditingController _hariController = TextEditingController();
  TextEditingController _NilaiController = TextEditingController();

  void _addData() {
    setState(() {
      _data.add(LinearNilai(
          _hariController.text, int.tryParse(_NilaiController.text) ?? 0));
      _hariController.clear();
      _NilaiController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          child: charts.BarChart(
            _createSampleData(_data),
            animate: true,
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _hariController,
          decoration: InputDecoration(hintText: 'Hari'),
        ),
        TextField(
          controller: _NilaiController,
          decoration: InputDecoration(hintText: 'Nilai'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: _addData,
          child: Text('Add Data'),
        ),
        Container(
          color: widget.color,
        ),
      ],
    );
  }
}

class LinearNilai {
  final String hari;
  final int Nilai;

  LinearNilai(this.hari, this.Nilai);
}
