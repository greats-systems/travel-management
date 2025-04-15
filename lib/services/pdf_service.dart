import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class PdfGenerator {
  static Future<File> generateFlightItineraryPdf(FlightBooking booking) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text('Flight Itinerary')),
              pw.SizedBox(height: 20),
              _buildFlightDetails(booking),
              pw.SizedBox(height: 20),
              _buildPassengerDetails(booking),
              pw.SizedBox(height: 20),
              _buildPriceDetails(booking),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
      "${output.path}/itinerary_${DateTime.now().millisecondsSinceEpoch}.pdf",
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildFlightDetails(FlightBooking booking) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Flight Details',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Divider(),
        ...booking.itineraries!.map((itinerary) {
          final segments = itinerary['segments'] as List;
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Text(
              //   '${itinerary['duration']} • ${segments.length} ${segments.length == 1 ? 'segment' : 'segments'}',
              // ),
              ...segments.map((segment) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${segment['departure']['iataCode']} to ${segment['arrival']['iataCode']}',
                    ),
                    pw.Text(
                      '${segment['departure']['at']} - ${segment['arrival']['at']}',
                    ),
                    pw.Text(
                      '${constants.returnCarrierName(segment['carrierCode'])} ${segment['carrierCode']}${segment['number']}',
                    ),
                    pw.SizedBox(height: 10),
                  ],
                );
              }),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildPassengerDetails(FlightBooking booking) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Passenger Details',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Divider(),
        ...booking.travelers!.map((traveler) {
          return pw.Text(
            '${traveler['name']['firstName']} ${traveler['name']['lastName']}',
          );
        }),
      ],
    );
  }

  static pw.Widget _buildPriceDetails(FlightBooking booking) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Price Details',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Divider(),
        pw.Text('Total: \$${booking.price!['total']}'),
        if (booking.price!['currency'] != 'USD')
          pw.Text('Currency: ${booking.price!['currency']}'),
      ],
    );
  }

  static Future<void> openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
