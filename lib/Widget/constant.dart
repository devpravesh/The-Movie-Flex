import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

var logger = Logger();

String imageUrl(endpoint) {
  return "https://image.tmdb.org/t/p/w500$endpoint";
}
String formatDate(String dateString) {
    try {
      // Attempt to parse the date string
      DateTime parsedDate = DateTime.parse(dateString);

      // Format the date if parsing is successful
      String formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);

      return formattedDate;
    } catch (e) {
      // If parsing fails, handle the error
      return 'Invalid date format';
    }
  }
  
  void launchURL(String url) async {
    final Uri url0 = Uri.parse(url);
    if (await canLaunchUrl(url0)) {
      await launchUrl(url0);
    } else {
      throw 'Could not launch $url';
    }
  }