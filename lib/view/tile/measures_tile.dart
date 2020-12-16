import 'package:flutter/material.dart';
import 'file:///D:/Users/marce/OneDrive/Documentos/Testes/realtimedatabase_teste/lib/model/measure/measure_data.dart';

class MeasuresTile extends StatelessWidget {

  final MeasureData measure;
  final int index;

  MeasuresTile(this.measure, this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(measure.measuresImages[index]),
          height: 50.0,
        ),
        Text(
          measure.measures[index].toString(),
          style: TextStyle(
              fontSize: 25.0
          ),
        ),
        Text(
            measure.units[index]
        )
      ],
    );
  }
}
