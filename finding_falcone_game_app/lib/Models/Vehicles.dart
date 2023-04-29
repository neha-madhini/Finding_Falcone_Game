class Vehicles {
    Vehicles({
        required this.name,
        required this.totalNo,
        required this.maxDistance,
        required this.speed,
    });

    String name;
    int totalNo;
    int maxDistance;
    int speed;

    factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        name: json["name"],
        totalNo: json["total_no"],
        maxDistance: json["max_distance"],
        speed: json["speed"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "total_no": totalNo,
        "max_distance": maxDistance,
        "speed": speed,
    };
}