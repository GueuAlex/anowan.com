import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketwave/widgets/sheet_closer_cross.dart';

class QrcodeDialog extends StatelessWidget {
  const QrcodeDialog({
    super.key,
    this.data = "bonjour",
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, minWidth: 350),
        child: Column(
          children: [
            sheetCloserCross(ctxt: context, text: 'Mon code QR'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: SizedBox(
                    width: size.width,
                    height: size.width,
                    child: Center(
                      child: QrImageView(
                        data: data, // Donnée à encoder dans le QR Code
                        version: QrVersions.auto,
                        gapless: false,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
