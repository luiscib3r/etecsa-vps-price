import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => view;

  Widget get view => MaterialApp(
        title: 'ETECSA VPS Price',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return view;
  }

  Widget get view => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                cpuInput,
                ramInput,
                hddInput,
                backupCheckBox,
                SizedBox(
                  height: 10,
                ),
                outputWidget,
                SizedBox(
                  height: 10,
                ),
                outputWidget10,
                SizedBox(
                  height: 10,
                ),
                dataTable,
              ],
            ),
          ),
        ),
      );

  double _cpu = 1;
  set cpu(double value) => setState(() => _cpu = value);
  double get cpu => _cpu;

  double _ram = 1;
  set ram(double value) => setState(() => _ram = value);
  double get ram => _ram;

  double _hdd = 20;
  set hdd(double value) => setState(() => _hdd = value);
  double get hdd => _hdd;

  Widget get dataTable => DataTable(
        columns: [
          dataColumn('Recurso'),
          dataColumn('Unidad'),
          dataColumn('Hora'),
          dataColumn('Diaria'),
          dataColumn('Mensual'),
        ],
        rows: [
          dataRow('CPU', 0.04),
          dataRow('RAM (GB)', 0.05),
          dataRow('HDD (GB)', 0.01),
        ],
      );

  DataColumn dataColumn(String text) => DataColumn(
        label: Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  DataRow dataRow(String recurso, double basePrice) => DataRow(
        cells: [
          DataCell(Text(recurso)),
          DataCell(Text('1')),
          DataCell(Text('$basePrice')),
          DataCell(Text('${(basePrice * 24).toStringAsFixed(2)}')),
          DataCell(Text('${(basePrice * 24 * 30).toStringAsFixed(2)}')),
        ],
      );

  Widget get cpuInput => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CPU $cpu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          cpuSlider,
        ],
      );

  Widget get cpuSlider => Expanded(
        child: Slider(
          min: 1,
          max: 8,
          divisions: 7,
          value: cpu,
          onChanged: (value) => cpu = value,
        ),
      );

  Widget get ramInput => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'RAM $ram GB',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ramSlider,
        ],
      );

  Widget get ramSlider => Expanded(
        child: Slider(
          min: 1,
          max: 16,
          divisions: 15,
          value: ram,
          onChanged: (value) => ram = value,
        ),
      );

  Widget get hddInput => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'HDD $hdd GB',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          hddSlider,
        ],
      );

  Widget get hddSlider => Expanded(
        child: Slider(
          min: 20,
          max: 500,
          divisions: 480,
          value: hdd,
          onChanged: (value) => hdd = value,
        ),
      );

  double get hourPrice =>
      cpu * 0.04 +
      ram * 0.05 +
      hdd * 0.01 +
      (useBackup ? (hdd * 0.01) * 0.75 : 0);

  double get dayPrice => hourPrice * 24;

  double get monthPrice => dayPrice * 30;

  Widget get hourPriceOutput => Row(
        children: [
          Text(
            'Hora: \$ ${hourPrice.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget get dayPriceOutput => Row(
        children: [
          Text(
            'Diaria: \$ ${dayPrice.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget get monthPriceOutput => Row(
        children: [
          Text(
            'Mensual: \$ ${monthPrice.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget get outputWidget => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TARIFA CUP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          hourPriceOutput,
          dayPriceOutput,
          monthPriceOutput,
        ],
      );

  Widget get hourPriceOutput10 => Row(
        children: [
          Text(
            'Hora: \$ ${(hourPrice - hourPrice * 0.10).toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget get dayPriceOutput10 => Row(
        children: [
          Text(
            'Diaria: \$ ${(dayPrice - dayPrice * 0.10).toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget get monthPriceOutput10 => Row(
        children: [
          Text(
            'Mensual: \$ ${(monthPrice - monthPrice * 0.10).toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  Widget get outputWidget10 => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TRANSFERMÓVIL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          hourPriceOutput10,
          dayPriceOutput10,
          monthPriceOutput10,
        ],
      );

  bool _useBackup = true;
  set useBackup(value) => setState(() => _useBackup = value);
  bool get useBackup => _useBackup;

  Widget get backupCheckBox => CheckboxListTile(
        title: Text("Usar VPS Backup (Costo 75% de HDD)"),
        value: useBackup,
        onChanged: (value) => useBackup = value,
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      );
}
