class Planets {
    Planets({
        required this.name,
        required this.distance,
    });

    String name;
    int distance;

    factory Planets.fromJson(Map<String, dynamic> json) => Planets(
        name: json["name"],
        distance: json["distance"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "distance": distance,
    };
}