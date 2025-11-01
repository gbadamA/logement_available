import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RevenusBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> revenus;

  const RevenusBarChart({super.key, required this.revenus});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final moisIndex = value.toInt();
                  if (moisIndex < revenus.length) {
                    return Text(
                      revenus[moisIndex]['mois'].substring(
                        0,
                        3,
                      ), // ex: Jan, Fév
                      style: const TextStyle(fontSize: 12),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          barGroups: revenus.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: (data['encaissé'] as int).toDouble(),
                  color: Colors.green,
                  width: 12,
                ),
                BarChartRodData(
                  toY: (data['enAttente'] as int).toDouble(),
                  color: Colors.redAccent,
                  width: 12,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
