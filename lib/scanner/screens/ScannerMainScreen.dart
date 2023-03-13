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
            const SizedBox(
              height: 100,
            ),
            const Text(
              "SANGATHAN QR",
              style:
                  TextStyle(color: AppColor.primaryColor, fontSize:30,fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(color: Colors.black, thickness: 0.2),
            GestureDetector(
              onTap: (){
                scanQRCode();
              },
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Click Here To Scan",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.qr_code)
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black, thickness: 0.2),
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
            child: const Text('Scan QR'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(getResult, style: TextStyle(fontWeight: FontWeight.w400),),
        ],
      )),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', "Cancel", true, ScanMode.QR);

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
