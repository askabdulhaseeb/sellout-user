import 'package:flutter/material.dart';

class DateOfBirth {
  DateOfBirth({this.date, this.month, this.year, this.isValid = false});
  int? date;
  int? month;
  int? year;
  bool? isValid;

  bool _isvalid() {
    if (date! > 0 &&
        date! <= 31 &&
        month! > 0 &&
        month! <= 12 &&
        year! >= 1900 &&
        year! <= DateTime.now().year) {
      return true;
    }
    return false;
  }

  update() {
    if (_isvalid()) {
      isValid = true;
    } else {
      isValid = false;
    }
  }

  String get dob => '$date-$month-$year = $isValid';
}

class DOBDropdown extends StatefulWidget {
  const DOBDropdown({required this.onChanged, Key? key}) : super(key: key);
  final void Function(DateOfBirth) onChanged;
  @override
  _DOBDropdownState createState() => _DOBDropdownState();
}

class _DOBDropdownState extends State<DOBDropdown> {
  int? _date;
  int? _month;
  int? _year;
  // ignore: prefer_final_fields
  DateOfBirth _dob = DateOfBirth(date: 0, month: 0, year: 0);
  final List<int> _dateList = <int>[for (int i = 1; i <= 31; i++) i];
  final List<int> _monthList = <int>[for (int i = 1; i <= 12; i++) i];
  final List<int> _yearList = <int>[
    for (int i = DateTime.now().year; i >= 1900; i--) i
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 4),
        DropdownButton<int>(
          alignment: Alignment.center,
          menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
          underline: const SizedBox(),
          hint: const Text('Date'),
          value: _date,
          items: _dateList
              .map((int e) => DropdownMenuItem<int>(
                    value: e,
                    child: Text('$e'),
                  ))
              .toList(),
          onChanged: (int? value) {
            setState(() {
              _date = value!;
              _dob.date = value;
            });
            _dob.update();
            widget.onChanged(_dob);
          },
        ),
        const SizedBox(width: 10),
        DropdownButton<int>(
          alignment: Alignment.center,
          menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
          underline: const SizedBox(),
          hint: const Text('Month'),
          value: _month,
          items: _monthList
              .map((int e) => DropdownMenuItem<int>(
                    value: e,
                    child: Text('$e'),
                  ))
              .toList(),
          onChanged: (int? value) {
            setState(() {
              _month = value!;
              _dob.month = value;
            });
            _dob.update();
            widget.onChanged(_dob);
          },
        ),
        const SizedBox(width: 10),
        DropdownButton<int>(
          alignment: Alignment.center,
          menuMaxHeight: MediaQuery.of(context).size.height * 0.7,
          underline: const SizedBox(),
          hint: const Text('Year'),
          value: _year,
          items: _yearList
              .map((int e) => DropdownMenuItem<int>(
                    value: e,
                    child: Text('$e'),
                  ))
              .toList(),
          onChanged: (int? value) {
            setState(() {
              _year = value!;
              _dob.year = value;
            });
            _dob.update();
            widget.onChanged(_dob);
          },
        ),
      ],
    );
  }
}
