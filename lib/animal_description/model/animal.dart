// tambahkan parameter 

class Animal {
  final String name;
  final String continent;
  final String fact;
  final List<Map<String, String>> description;
  final String modelPath;
  final String imagePath;

  Animal({
    required this.name,
    required this.continent,
    required this.description,
    required this.fact,
    required this.modelPath,
    required this.imagePath,
  });
}
