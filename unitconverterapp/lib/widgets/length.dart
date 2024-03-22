import 'package:flutter/material.dart';

class LengthAction extends StatefulWidget {
  const LengthAction({Key? key}) : super(key: key);

  @override
  State<LengthAction> createState() => _LengthActionState();
}

class _LengthActionState extends State<LengthAction> {
  String _from = 'cm';
  String _to = 'feet';
  double _value = 0;
  double _answer = 0;
  TextEditingController _textFieldController = TextEditingController();

  void convert(String from, String to, double value) {
    if (value == 0) {
      return;
    }

    if (from == 'cm' && to == 'feet') {
      setState(() {
        _answer = value * 0.0328084;
      });
    }
    if (from == 'feet' && to == 'cm') {
      setState(() {
        _answer = value / 0.0328084;
      });
    }
    if (from == 'inches' && to == 'cm') {
      setState(() {
        _answer = value * 2.54;
      });
    }
    if (from == 'cm' && to == 'inches') {
      setState(() {
        _answer = value / 2.54;
      });
    }
    if (from == 'inches' && to == 'feet') {
      setState(() {
        _answer = value * 12;
      });
    }
    if (from == 'feet' && to == 'inches') {
      setState(() {
        _answer = value / 12;
      });
    }

    if (from == to) {
      setState(() {
        _answer = value;
      });
    }
    FocusScope.of(context).unfocus();
  }

  void reset() {
    setState(() {
      _textFieldController.clear();
      _value = 0;
      _answer = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var result = _answer.toStringAsFixed(2);
    return Column(
      children: [
        Row(
          children: [
            fromDropDown,
            const SizedBox(
              width: 100,
            ),
            toDropDown,
            const SizedBox(
              height: 35,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width * 0.30,
              child: TextField(
                controller: _textFieldController,
                cursorHeight: 20,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Enter value...',
                    floatingLabelBehavior: FloatingLabelBehavior.never),
                onChanged: (value) {
                  setState(() {
                    _value = double.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              _from,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              width: 15,
            ),
            const Text(
              '=',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width * 0.17,
              child: Text(
                result,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              _to == 'inches' ? 'inch' : _to,
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
        const SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.lightGreen;
                  }
                  return Colors.green;
                }),
              ),
              onPressed: () => convert(_from, _to, _value),
              child: const Text(
                'Convert',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.redAccent;
                  }
                  return Colors.green;
                }),
              ),
              onPressed: reset,
              child: const Text(
                'Reset',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  DropdownButton<String> get toDropDown {
    return DropdownButton(
        value: _to,
        items: const [
          DropdownMenuItem(
            value: 'inches',
            child: Text(
              'Inches',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DropdownMenuItem(
            value: 'feet',
            child: Text(
              "Feet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DropdownMenuItem(
            value: 'cm',
            child: Text(
              "Centimeters",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        onChanged: (to) {
          setState(() {
            _to = to!;
          });
        });
  }

  DropdownButton<String> get fromDropDown {
    return DropdownButton(
      value: _from,
      items: const [
        DropdownMenuItem(
          value: 'inches',
          child: Text(
            "Inches",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          value: 'feet',
          child: Text(
            "Feet",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DropdownMenuItem(
          value: 'cm',
          child: Text(
            "Centimeters",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      hint: const Text('Length Scale'),
      onChanged: (from) {
        setState(() {
          _from = from!;
        });
      },
    );
  }
}
