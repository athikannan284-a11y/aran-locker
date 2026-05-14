import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiServiceProvider = Provider<AIService>((ref) => AIService());

class AIService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String> performOCR(File file) async {
    final inputImage = InputImage.fromFile(file);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  String classifyDocument(String text) {
    final lowerText = text.toLowerCase();
    
    if (lowerText.contains('aadhaar') || lowerText.contains('government of india')) {
      return 'Aadhaar Card';
    } else if (lowerText.contains('income tax') || lowerText.contains('permanent account number') || lowerText.contains('pan card')) {
      return 'PAN Card';
    } else if (lowerText.contains('passport') || lowerText.contains('republic of india')) {
      return 'Passport';
    } else if (lowerText.contains('driving license') || lowerText.contains('transport department')) {
      return 'Driving License';
    } else if (lowerText.contains('voter id') || lowerText.contains('election commission')) {
      return 'Voter ID';
    } else if (lowerText.contains('insurance') || lowerText.contains('policy')) {
      return 'Insurance';
    } else if (lowerText.contains('registration certificate') || lowerText.contains('vehicle rc')) {
      return 'Vehicle RC';
    } else if (lowerText.contains('medical') || lowerText.contains('hospital') || lowerText.contains('report')) {
      return 'Medical Record';
    } else if (lowerText.contains('bank') || lowerText.contains('statement') || lowerText.contains('account')) {
      return 'Bank Document';
    } else if (lowerText.contains('certificate') || lowerText.contains('marksheet')) {
      return 'Education';
    }
    
    return 'Personal File';
  }

  String getCategory(String docType) {
    switch (docType) {
      case 'Aadhaar Card':
      case 'PAN Card':
      case 'Passport':
      case 'Driving License':
      case 'Voter ID':
        return 'Government IDs';
      case 'Bank Document':
        return 'Banking';
      case 'Education':
        return 'Education';
      case 'Vehicle RC':
        return 'Vehicle Documents';
      case 'Medical Record':
        return 'Medical Records';
      default:
        return 'Personal Files';
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}
