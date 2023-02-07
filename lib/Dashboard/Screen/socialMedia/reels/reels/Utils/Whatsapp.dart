import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { whatsapp }

Future shareOnWhatsapp(SocialMedia socialMedia, SocialMedia whatsapp, int index) async {
  const text = "Shared from Whatsapp";
  final urlShare = Uri.encodeComponent("https://youtu.be/arzXF2HTX9g");
  final urlimage = Uri.encodeComponent("https://i.imgur.com/OVeZPK1.jpg");

  final urls = {
    SocialMedia.whatsapp: 'whatsapp://send?text=$text$urlShare&photo=$urlimage',
  };
  final url = urls[socialMedia]!;

  launchUrl(Uri.parse(url));
}
