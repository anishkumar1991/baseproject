import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sangathan/Values/app_colors.dart';

import 'QrScreen.dart';

class ScannerMainScreen extends StatefulWidget {
  const ScannerMainScreen({Key? key}) : super(key: key);

  @override
  State<ScannerMainScreen> createState() => _ScannerMainScreenState();
}

class _ScannerMainScreenState extends State<ScannerMainScreen> {
  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 200,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Sangathan QR Scanner",

              style: TextStyle(color:AppColor.red,fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Scan QR Code",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {
                      scanQRCode();
                    },
                    icon: Icon(Icons.qr_code))
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
          backgroundColor: AppColor().appBarColor,
          title: Text("Sangathan - QR Scanner Page",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColor().textColor)),
          centerTitle: true,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.qr_code),
              color: Colors.black,
            );
          }),
          automaticallyImplyLeading: false,
          titleSpacing: 0),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              scanQRCode();
            },
            child: Text('Scan QR'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(getResult),
        ],
      )),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666' , "Cancel", true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
