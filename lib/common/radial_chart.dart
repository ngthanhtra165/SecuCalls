import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as chart;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialChart extends StatelessWidget {
  final String label;
  final double value;
  final Color color;


  RadialChart({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width / 2 - 30;
    const _valueFontSize = 40.0;
    const _fontFamily = 'ABeeZee';
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: _width,
          height: 30,
          child: Text(label, style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade500
          ), textAlign: TextAlign.center),
        ),
        SizedBox(
          width: _width,
          height: _width,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  radiusFactor: 0.8,
                  axisLineStyle: const AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        angle: 180,
                        widget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                  fontFamily: _fontFamily,
                                  fontSize: _valueFontSize,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                            ),
                            const Text(
                              '%',
                              style: TextStyle(
                                  fontFamily: _fontFamily,
                                  fontSize: _valueFontSize,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                  ],
                  pointers: <GaugePointer>[
                    RangePointer(
                        value: value,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationDuration: 1200,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: SweepGradient(
                            colors: <Color>[color, color],
                            stops: const <double>[0.25, 0.75]),
                        color: const Color(0xFF00A8B5),
                        width: 0.15),
                  ]),
            ],
          ),
        )
      ],
    );

  }

}