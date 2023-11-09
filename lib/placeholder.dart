import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlaceholderWidget extends StatefulWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  List<charts.Series<LinearSales, String>> _createSampleData(
      List<LinearSales> data) {
    return [
      charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.day,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  List<LinearSales> _data = [
    LinearSales('Mon', 5),
    LinearSales('Tue', 25),
    LinearSales('Wed', 100),
    LinearSales('Thu', 75),
  ];

  TextEditingController _dayController = TextEditingController();
  TextEditingController _salesController = TextEditingController();

  void _addData() {
    setState(() {
      _data.add(LinearSales(
          _dayController.text, int.tryParse(_salesController.text) ?? 0));
      _dayController.clear();
      _salesController.clear();
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
          controller: _dayController,
          decoration: InputDecoration(hintText: 'Day'),
        ),
        TextField(
          controller: _salesController,
          decoration: InputDecoration(hintText: 'Sales'),
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

class LinearSales {
  final String day;
  final int sales;

  LinearSales(this.day, this.sales);
}
