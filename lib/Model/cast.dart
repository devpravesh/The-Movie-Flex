// To parse this JSON data, do
//
//     final cast = castFromJson(jsonString);

import 'dart:convert';

Cast castFromJson(String str) => Cast.fromJson(json.decode(str));

String castToJson(Cast data) => json.encode(data.toJson());

class Cast {
    int? id;
    List<CastElement>? cast;
    List<CastElement>? crew;

    Cast({
        this.id,
        this.cast,
        this.crew,
    });

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        cast: json["cast"] == null ? [] : List<CastElement>.from(json["cast"]!.map((x) => CastElement.fromJson(x))),
        crew: json["crew"] == null ? [] : List<CastElement>.from(json["crew"]!.map((x) => CastElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": cast == null ? [] : List<dynamic>.from(cast!.map((x) => x.toJson())),
        "crew": crew == null ? [] : List<dynamic>.from(crew!.map((x) => x.toJson())),
    };
}

class CastElement {
    bool? adult;
    int? gender;
    int? id;
    Department? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    int? castId;
    String? character;
    String? creditId;
    int? order;
    Department? department;
    String? job;

    CastElement({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
        this.department,
        this.job,
    });

    factory CastElement.fromJson(Map<String, dynamic> json) => CastElement(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: departmentValues.map[json["department"]]!,
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": departmentValues.reverse[department],
        "job": job,
    };
}

enum Department {
    ACTING,
    ART,
    CAMERA,
    COSTUME_MAKE_UP,
    CREW,
    DIRECTING,
    EDITING,
    LIGHTING,
    PRODUCTION,
    SOUND,
    VISUAL_EFFECTS,
    WRITING
}

final departmentValues = EnumValues({
    "Acting": Department.ACTING,
    "Art": Department.ART,
    "Camera": Department.CAMERA,
    "Costume & Make-Up": Department.COSTUME_MAKE_UP,
    "Crew": Department.CREW,
    "Directing": Department.DIRECTING,
    "Editing": Department.EDITING,
    "Lighting": Department.LIGHTING,
    "Production": Department.PRODUCTION,
    "Sound": Department.SOUND,
    "Visual Effects": Department.VISUAL_EFFECTS,
    "Writing": Department.WRITING
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
