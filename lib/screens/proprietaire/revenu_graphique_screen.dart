import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenusGraphiqueScreen extends StatelessWidget {
  final int encaisse;
  final int enAttente;

  const RevenusGraphiqueScreen({
    super.key,
    required this.encaisse,
    required this.enAttente,
  });

  @override
  Widget build(BuildContext context) {
    final total = encaisse + enAttente;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Répartition des revenus",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: encaisse.toDouble(),
                      color: Colors.green,
                      title:
                          "${((encaisse / total) * 100).toStringAsFixed(1)}%",
                      radius: 80,
                      titleStyle: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      value: enAttente.toDouble(),
                      color: Colors.redAccent,
                      title:
                          "${((enAttente / total) * 100).toStringAsFixed(1)}%",
                      radius: 80,
                      titleStyle: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Payé : $encaisse CFA",
              style: GoogleFonts.manrope(fontSize: 16, color: Colors.green),
            ),
            Text(
              "En attente : $enAttente CFA",
              style: GoogleFonts.manrope(fontSize: 16, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
