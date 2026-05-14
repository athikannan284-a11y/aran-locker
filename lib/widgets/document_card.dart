import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/app_colors.dart';
import '../models/document_model.dart';
import 'glass_card.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback onTap;

  const DocumentCard({
    super.key,
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(12),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Icon(
                    _getIcon(document.documentType),
                    color: AppColors.accent,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              document.documentType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              document.category,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'Aadhaar Card':
      case 'PAN Card':
      case 'Voter ID':
        return FontAwesomeIcons.idCard;
      case 'Passport':
        return FontAwesomeIcons.passport;
      case 'Driving License':
      case 'Vehicle RC':
        return FontAwesomeIcons.car;
      case 'Medical Record':
        return FontAwesomeIcons.fileMedical;
      case 'Bank Document':
        return FontAwesomeIcons.buildingColumns;
      default:
        return FontAwesomeIcons.fileLines;
    }
  }
}
