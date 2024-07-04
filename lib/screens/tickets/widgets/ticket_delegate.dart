import 'package:flutter/material.dart';

class DottedMiddlePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5;
    double dashSpace = 4;
    double startY = 12;
    final paint = Paint()
      ..color = Color.fromARGB(255, 201, 201, 201)
      ..strokeWidth = 1;

    while (startY < 150.0 - 12) {
      canvas.drawCircle(Offset(size.width / 1.6, startY), 2, paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SideCutsDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = 150.0;
    var w = size.width;
    var radius = 10.0; // Augmentez le rayon pour augmenter la taille des arcs

    // Arcs blancs (fond)
    var paintFill = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromARGB(255, 255, 255, 255);

    // Bordure des arcs
    var paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 225, 225, 225)
      ..strokeWidth = 2; // Ajustez la largeur de la bordure ici

    // Dessiner les arcs
    var arcRectTop =
        Rect.fromCircle(center: Offset(w / 1.6, 0), radius: radius);
    var arcRectBottom =
        Rect.fromCircle(center: Offset(w / 1.6, h), radius: radius);

    // Dessiner les arcs remplis
    canvas.drawArc(arcRectTop, 0, 10, false, paintFill);
    canvas.drawArc(arcRectBottom, 0, 10, false, paintFill);

    // Dessiner les bordures des arcs
    // Pour l'arc supérieur, dessiner de 0 à 180 degrés (partie inférieure de l'arc)
    canvas.drawArc(arcRectTop, 0, 3.14159, false, paintStroke);
    // Pour l'arc inférieur, dessiner de 180 à 360 degrés (partie supérieure de l'arc)
    canvas.drawArc(arcRectBottom, 3.14159, 3.14159, false, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
