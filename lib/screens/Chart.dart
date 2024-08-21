import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

import 'package:loading_indicator/loading_indicator.dart';

class IsolatesChart extends StatefulWidget {
  const IsolatesChart({Key? key}) : super(key: key);

  @override
  State<IsolatesChart> createState() => _IsolatesChartState();
}

class _IsolatesChartState extends State<IsolatesChart> {
  Map<String, int>? deviceCountByBrand;
  late List<Color> colors;
  late int totalDevices;

  @override
  void initState() {
    super.initState();
    colors = Colors.primaries;
    _loadData();
  }

  Future<void> _loadData() async {
    //Substituir pelo endpoint
    final response = await Dio().get('ENDPOINT_HERE');
    final phones = response.data;

    final receivePort = ReceivePort();
    await Isolate.spawn(_countDevicesByBrand, [receivePort.sendPort, phones]);

    receivePort.listen(
      (data) {
        setState(
          () {
            deviceCountByBrand = data;
            totalDevices = deviceCountByBrand!.values.reduce((a, b) => a + b);
          },
        );
        receivePort.close();
      },
    );
  }

  static void _countDevicesByBrand(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final List<dynamic> phones = args[1];

    final Map<String, int> countByBrand = {};
    for (var phone in phones) {
      final brand = phone['brand'] as String;
      countByBrand[brand] = (countByBrand[brand] ?? 0) + 1;
    }

    sendPort.send(countByBrand);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: deviceCountByBrand == null
            ? const Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScale,
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final bool isSmallScreen = constraints.maxWidth < 400;
                  return Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("DISPOSITIVOS UTILIZADOS",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline1),
                              SizedBox(
                                height: isSmallScreen ? 40 : 30,
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.8,
                                height: constraints.maxHeight * 0.4,
                                child: PieChart(
                                  PieChartData(
                                    sections: deviceCountByBrand!.entries.map(
                                      (entry) {
                                        final int index = deviceCountByBrand!
                                            .keys
                                            .toList()
                                            .indexOf(entry.key);
                                        final Color color =
                                            colors[index % colors.length];
                                        return PieChartSectionData(
                                          value: entry.value.toDouble(),
                                          title: '',
                                          color: color,
                                          radius: isSmallScreen ? 40 : 50,
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: isSmallScreen ? 40 : 30,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 10 : 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: deviceCountByBrand!.entries.map(
                                    (entry) {
                                      final int index = deviceCountByBrand!.keys
                                          .toList()
                                          .indexOf(entry.key);
                                      final Color color =
                                          colors[index % colors.length];
                                      final int count = entry.value;
                                      final double percentage =
                                          (count / totalDevices) * 100;

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              color: color,
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                            ),
                                            Text(
                                              '${entry.key} (${percentage.toStringAsFixed(1)}%)',
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 14 : 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
