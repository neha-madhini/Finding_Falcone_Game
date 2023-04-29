class PlanetName {
    PlanetName({
        required this.planetName,
        required this.status,
    });

    String? planetName;
    String? status;

    factory PlanetName.fromJson(Map<String, dynamic> json) => PlanetName(
        planetName: json["planet_name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "planet_name": planetName,
        "status": status,
    };
}