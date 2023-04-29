class FindRequest {
    FindRequest({
        required this.token,
        required this.planetNames,
        required this.vehicleNames,
    });

    String token;
    List<String> planetNames;
    List<String> vehicleNames;

    factory FindRequest.fromJson(Map<String, dynamic> json) => FindRequest(
        token: json["token"],
        planetNames: List<String>.from(json["planet_names"].map((x) => x)),
        vehicleNames: List<String>.from(json["vehicle_names"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "planet_names": List<dynamic>.from(planetNames.map((x) => x)),
        "vehicle_names": List<dynamic>.from(vehicleNames.map((x) => x)),
    };
}