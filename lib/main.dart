import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MaterialApp(home: BillSplitter()));
}

class BillSplitter extends StatefulWidget {
  const BillSplitter({super.key});

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  double _totAmt = 0.0;
  int _perc = 0;
  double _tipAmt = 0.0;
  int _personCounter = 1;
  double _billAmt = 0.0;
  Color _purple = HexColor("#6908D6");

  String calcAmt(double billAmt, int noPersons, int tipPerc) {
    double totAmt = billAmt + (0.01 * billAmt * tipPerc);
    return (totAmt / noPersons).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total per person",
                    style: TextStyle(
                        color: _purple,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("${calcAmt(_billAmt, _personCounter, _tipPercentage)}",
                      style: TextStyle(
                          color: _purple,
                          fontSize: 17,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.0)),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        setState(() {
                          _billAmt = double.parse(value);
                        });
                      } catch (exception) {
                        _billAmt = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter -= 1;
                                }
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                  child: Text(
                                "$_personCounter",
                                style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              )),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _personCounter += 1;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      Center(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "\$ $_tipAmt",
                              style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            color: _purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          value: _perc.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _perc = value.round();
                              _tipPercentage = value.round();
                              _tipAmt = double.parse(
                                  (_billAmt * _tipPercentage * 0.01)
                                      .toStringAsFixed(2));
                            });
                          })
                    ],
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
