import 'package:bill_splitter/utils/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSpliter extends StatefulWidget {
  const BillSpliter({Key? key}) : super(key: key);

  @override
  State<BillSpliter> createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {
  int _tipPercentage = 0;
  int _personCount = 1;
  double _billAmount = 0.0;
  Color _purple = HexColor('#6908D6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [Text('Total Per Person', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: _purple
                ),), Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('\$ ${calculateTotalPerPerson(_tipPercentage, _billAmount, _personCount)}', style: TextStyle(
                    color: _purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.9
                  ),),
                )],
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              margin: const EdgeInsets.only(top: 20.0),
              // padding: EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(prefixText: 'Bill Amount', prefixIcon: Icon(Icons.monetization_on_outlined)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCount > 1) {
                                  _personCount--;
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.05),
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(color: _purple, fontWeight: FontWeight.bold, fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCount",
                            style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCount++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.05),
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(color: _purple, fontWeight: FontWeight.bold, fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '\$ ${(calculateTotalTip(_billAmount, _personCount, _tipPercentage)).toStringAsFixed(2)}',
                          style: TextStyle(color: _purple, fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  //slider
                  Column(
                    
                    children: [
                      Text(
                        '$_tipPercentage%',
                        style: TextStyle(color: _purple, fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson( int tipPercentage, double billAmount, int splitBy){
  var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount)/ splitBy;
  return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
     double totalTip = 0.0;
     if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null ){

     }else{
       totalTip = (billAmount * tipPercentage) /100;
     }
     return totalTip;
  }
}
