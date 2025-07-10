import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/dashboard/provider.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';
import 'package:fl_chart/fl_chart.dart';

class dashboardPage extends StatelessWidget {
  const dashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<providerDashboard>(context);
    final chartData = prov.filteredChartData;

    return Scaffold(
      appBar: CustomAppBar(title: 'Dashboard'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome, John",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Still got 2 bookmarks to finish reading",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),

                  // Quiz Result Card
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white70
                                : Colors.green.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF3A3A3A)
                                    : Colors.green.shade50,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Quiz Result",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 200,
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 40,
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            int index = value.toInt();
                                            if (index >= 0 &&
                                                index < chartData.length) {
                                              return Text(
                                                chartData[index]['day'],
                                              );
                                            } else {
                                              return const Text('');
                                            }
                                          },
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    lineTouchData: LineTouchData(
                                      handleBuiltInTouches: true,
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipBgColor: Colors.grey,
                                        getTooltipItems: (touchedSpots) {
                                          return touchedSpots.map((spot) {
                                            return LineTooltipItem(
                                              '${spot.y.toInt()}',
                                              TextStyle(color: Colors.white),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),

                                    lineBarsData: [
                                      LineChartBarData(
                                        spots:
                                            chartData
                                                .asMap()
                                                .entries
                                                .map(
                                                  (e) => FlSpot(
                                                    e.key.toDouble(),
                                                    e.value['score'].toDouble(),
                                                  ),
                                                )
                                                .toList(),
                                        isCurved: true,
                                        barWidth: 3,
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Color(0xFFF5F5F5)
                                                : Colors.green,
                                        dotData: FlDotData(show: true),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(height: 1, thickness: 3),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ChoiceChip(
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (prov.selectedPeriod == 'day') ...[
                                          Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                        ],
                                        Text(
                                          'Day',
                                          style: TextStyle(
                                            color:
                                                prov.selectedPeriod == 'day'
                                                    ? Theme.of(
                                                              context,
                                                            ).brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Color(0xFF333739)
                                                    : Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Color(0xFF1E1E1E),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    selected: prov.selectedPeriod == 'day',
                                    showCheckmark: false,
                                    selectedColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFFF5F5F5)
                                            : Colors.green.shade400,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFF2E2E2E)
                                            : Color(0xFFE8F5E9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.grey
                                                : Colors.green.shade200,
                                      ),
                                    ),
                                    onSelected:
                                        (_) => prov.setSelectedPeriod('day'),
                                  ),
                                  const SizedBox(width: 8),
                                  ChoiceChip(
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (prov.selectedPeriod == 'week') ...[
                                          Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                        ],
                                        Text(
                                          'Week',
                                          style: TextStyle(
                                            color:
                                                prov.selectedPeriod == 'week'
                                                    ? Theme.of(
                                                              context,
                                                            ).brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Color(0xFF333739)
                                                    : Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Color(0xFF1E1E1E),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    selected: prov.selectedPeriod == 'week',
                                    showCheckmark: false,
                                    selectedColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFFF5F5F5)
                                            : Colors.green.shade400,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFF2E2E2E)
                                            : Color(0xFFE8F5E9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.grey
                                                : Colors.green.shade200,
                                      ),
                                    ),
                                    onSelected:
                                        (_) => prov.setSelectedPeriod('week'),
                                  ),
                                  const SizedBox(width: 8),
                                  ChoiceChip(
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (prov.selectedPeriod == 'month') ...[
                                          Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.black
                                                    : Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(width: 4),
                                        ],
                                        Text(
                                          'Month',
                                          style: TextStyle(
                                            color:
                                                prov.selectedPeriod == 'month'
                                                    ? Theme.of(
                                                              context,
                                                            ).brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Color(0xFF333739)
                                                    : Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Color(0xFF1E1E1E),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    selected: prov.selectedPeriod == 'month',
                                    showCheckmark: false,
                                    selectedColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFFF5F5F5)
                                            : Colors.green.shade400,
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFF2E2E2E)
                                            : Color(0xFFE8F5E9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.grey
                                                : Colors.green.shade200,
                                      ),
                                    ),
                                    onSelected:
                                        (_) => prov.setSelectedPeriod('month'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Bookmark Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white70
                                : Colors.green.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF3A3A3A)
                                    : Colors.green.shade50,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Bookmark",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'lib/assets/images/tiger.jpg',
                                      width: 140,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Harimau",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "75%",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'lib/assets/images/badak.jpeg',
                                      width: 140,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Badak",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "30%",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
