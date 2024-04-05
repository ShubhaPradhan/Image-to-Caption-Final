class CaptionGenerationResponse {
  String? caption;
  String? imageUrl;
  String? attentionImageUrl;
  DateTime? uploadedAt;

  CaptionGenerationResponse({
    this.caption,
    this.imageUrl,
    this.attentionImageUrl,
    this.uploadedAt,
  });

  factory CaptionGenerationResponse.fromJson(Map<String, dynamic> json) =>
      CaptionGenerationResponse(
        caption: json["caption"],
        imageUrl: json["image_url"],
        attentionImageUrl: json["attention_image_url"],
        uploadedAt: json["uploaded_at"] == null
            ? null
            : DateTime.parse(json["uploaded_at"]),
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "image_url": imageUrl,
        "attention_image_url": attentionImageUrl,
        "uploaded_at": uploadedAt?.toIso8601String(),
      };
}
