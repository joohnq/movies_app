class Backdrop {
  String filePath;

  Backdrop({
    required this.filePath,
  });

  factory Backdrop.fromJson(Map<dynamic, dynamic> json) => Backdrop(
        filePath: json["file_path"],
      );

  Map<dynamic, dynamic> toJson() => {
        "file_path": filePath,
      };
}
