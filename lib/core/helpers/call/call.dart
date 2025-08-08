import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri url = Uri(scheme: 'tel', path: "+02$phoneNumber");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}


Future<void> openWhatsApp({required String phone, String message = ""}) async {
  final url = Uri.parse("https://wa.me/+02$phone?text=${Uri.encodeComponent(message)}");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'لا يمكن فتح واتساب على هذا الجهاز';
  }
}

