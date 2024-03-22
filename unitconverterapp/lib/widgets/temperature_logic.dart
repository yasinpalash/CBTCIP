import 'package:flutter/material.dart';

class TemperatureLogic extends StatefulWidget {
  const TemperatureLogic({super.key});

  @override
  State<TemperatureLogic> createState() => _TemperatureLogicState();
}

class _TemperatureLogicState extends State<TemperatureLogic> {
  String _from = 'dc';
  String _to = 'df';
  double _value = 0;
  double _answer = 0;
  TextEditingController _textEditingController = TextEditingController();

  void temperatureConvert(String from, String to, double value) async {
    if (value == 0) {
      return;
    }
    if (from == to) {
      setState(() {
        _answer = value;
      });
    }
    if (from == 'dc' && to == 'df') {
      setState(() {
        _answer = (value * 9) / 5 + 32;
      });
    }
    if (from == 'df' && to == 'dc') {
      setState(() {
        _answer = ((value - 32) * 5) / 9;
      });
    }
    FocusScope.of(context).unfocus();
  }

  void reset() {
    setState(() {
      _textEditingController.clear();
      _value = 0;
      _answer = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var result = _answer.toStringAsFixed(2);
    return Column(
      children: [
        fromDropDown(),
        const SizedBox(
          height: 20,
        ),
        toDropDown(context, result),
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
              onPressed: () => temperatureConvert(_from, _to, _value),
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

  Row toDropDown(BuildContext context, String result) {
    return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 0.32,
            child: TextField(
              controller: _textEditingController,
              cursorHeight: 20,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  labelText: 'Enter value...',
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              onChanged: (value) {
                _value = double.tryParse(value)!;
              },
            ),
          ),
          Text(
            _from == 'dc' ? " \u2103" : " \u2109",
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(
            width: 25,
          ),
          const Text(
            '=',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              result,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            _to == 'dc' ? " \u2103" : " \u2109",
            style: const TextStyle(fontSize: 22),
          )
        ],
      );
  }

  Row fromDropDown() {
    return Row(
        children: [
          DropdownButton(
            value: _from,
            items: const [
              DropdownMenuItem(
                value: 'dc',
                child: Text(
                  "Celsius " + "\u2103",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DropdownMenuItem(
                value: 'df',
                child: Text(
                  "Fahrenheit" + " \u2109",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            hint: const Text('temperature Scale'),
            onChanged: (from) {
              setState(() {
                _from = from!;
              });
            },
          ),
          const SizedBox(
            width: 30,
          ),
          DropdownButton(
              value: _to,
              items: const [
                DropdownMenuItem(
                    value: 'dc',
                    child: Text(
                      "Celsius " + "\u2103 ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                DropdownMenuItem(
                    value: 'df',
                    child: Text(
                      "Fahrenheit" + " \u2109",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
              hint: const Text('Temperature Scale'),
              onChanged: (to) {
                _to = to!;
              })
        ],
      );
  }
}
