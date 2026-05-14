import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentModel {
  final String documentId;
  final String userId;
  final String documentType;
  final String category;
  final String fileURL;
  final String? thumbnailURL;
  final String? ocrText;
  final Map<String, dynamic>? metadata;
  final List<String> tags;
  final DateTime? expiryDate;
  final bool encrypted;
  final DateTime createdAt;

  DocumentModel({
    required this.documentId,
    required this.userId,
    required this.documentType,
    required this.category,
    required this.fileURL,
    this.thumbnailURL,
    this.ocrText,
    this.metadata,
    this.tags = const [],
    this.expiryDate,
    this.encrypted = true,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'userId': userId,
      'documentType': documentType,
      'category': category,
      'fileURL': fileURL,
      'thumbnailURL': thumbnailURL,
      'OCRText': ocrText,
      'metadata': metadata,
      'tags': tags,
      'expiryDate': expiryDate != null ? Timestamp.fromDate(expiryDate!) : null,
      'encrypted': encrypted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      documentId: map['documentId'] ?? '',
      userId: map['userId'] ?? '',
      documentType: map['documentType'] ?? '',
      category: map['category'] ?? '',
      fileURL: map['fileURL'] ?? '',
      thumbnailURL: map['thumbnailURL'],
      ocrText: map['OCRText'],
      metadata: map['metadata'],
      tags: List<String>.from(map['tags'] ?? []),
      expiryDate: map['expiryDate'] != null ? (map['expiryDate'] as Timestamp).toDate() : null,
      encrypted: map['encrypted'] ?? true,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
