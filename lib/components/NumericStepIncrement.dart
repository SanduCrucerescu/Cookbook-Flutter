import 'package:cookbook/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  int counter;

  final ValueChanged<int> onChanged;

  NumericStepButton(
      {Key? key,
      this.minValue = 1,
      this.maxValue = 52,
      required this.counter,
      required this.onChanged})
      : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  //int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
              height: 50,
              width: 100,
              child: InkWell(
                child: const Icon(
                  Icons.remove,
                  color: kcDarkBeige,
                ),
                onTap: () {
                  setState(() {
                    if (widget.counter > widget.minValue) {
                      widget.counter--;
                    }
                    widget.onChanged(widget.counter);
                  });
                },
              )),
          Text(
            '${widget.counter}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: 50,
            width: 100,
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            child: InkWell(
              child: const Icon(
                Icons.add,
                color: kcDarkBeige,
              ),
              onTap: () {
                setState(() {
                  if (widget.counter < widget.maxValue) {
                    widget.counter++;
                  }
                  widget.onChanged(widget.counter);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
