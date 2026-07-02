/// bodyPart : "waist"
/// equipment : "body weight"
/// id : "0001"
/// name : "3/4 sit-up"
/// target : "abs"
/// secondaryMuscles : ["hip flexors","lower back"]
/// instructions : ["Lie flat on your back with your knees bent and feet flat on the ground.","Place your hands behind your head with your elbows pointing outwards.","Engaging your abs, slowly lift your upper body off the ground, curling forward until your torso is at a 45-degree angle.","Pause for a moment at the top, then slowly lower your upper body back down to the starting position.","Repeat for the desired number of repetitions."]
/// description : "The 3/4 sit-up is an abdominal exercise performed with body weight. It involves curling the torso up to a 45-degree angle, engaging the abs, hip flexors, and lower back. This movement is commonly used to build core strength and stability."
/// difficulty : "beginner"
/// category : "strength"

class ExerciseModel {
  ExerciseModel({
      String? bodyPart, 
      String? equipment, 
      String? id, 
      String? name, 
      String? target, 
      List<String>? secondaryMuscles, 
      List<String>? instructions, 
      String? description, 
      String? difficulty, 
      String? category,}){
    _bodyPart = bodyPart;
    _equipment = equipment;
    _id = id;
    _name = name;
    _target = target;
    _secondaryMuscles = secondaryMuscles;
    _instructions = instructions;
    _description = description;
    _difficulty = difficulty;
    _category = category;
}

  ExerciseModel.fromJson(dynamic json) {
    _bodyPart = json['bodyPart'];
    _equipment = json['equipment'];
    _id = json['id'];
    _name = json['name'];
    _target = json['target'];
    _secondaryMuscles = json['secondaryMuscles'] != null ? json['secondaryMuscles'].cast<String>() : [];
    _instructions = json['instructions'] != null ? json['instructions'].cast<String>() : [];
    _description = json['description'];
    _difficulty = json['difficulty'];
    _category = json['category'];
  }
  String? _bodyPart;
  String? _equipment;
  String? _id;
  String? _name;
  String? _target;
  List<String>? _secondaryMuscles;
  List<String>? _instructions;
  String? _description;
  String? _difficulty;
  String? _category;
ExerciseModel copyWith({  String? bodyPart,
  String? equipment,
  String? id,
  String? name,
  String? target,
  List<String>? secondaryMuscles,
  List<String>? instructions,
  String? description,
  String? difficulty,
  String? category,
}) => ExerciseModel(  bodyPart: bodyPart ?? _bodyPart,
  equipment: equipment ?? _equipment,
  id: id ?? _id,
  name: name ?? _name,
  target: target ?? _target,
  secondaryMuscles: secondaryMuscles ?? _secondaryMuscles,
  instructions: instructions ?? _instructions,
  description: description ?? _description,
  difficulty: difficulty ?? _difficulty,
  category: category ?? _category,
);
  String? get bodyPart => _bodyPart;
  String? get equipment => _equipment;
  String? get id => _id;
  String? get name => _name;
  String? get target => _target;
  List<String>? get secondaryMuscles => _secondaryMuscles;
  List<String>? get instructions => _instructions;
  String? get description => _description;
  String? get difficulty => _difficulty;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bodyPart'] = _bodyPart;
    map['equipment'] = _equipment;
    map['id'] = _id;
    map['name'] = _name;
    map['target'] = _target;
    map['secondaryMuscles'] = _secondaryMuscles;
    map['instructions'] = _instructions;
    map['description'] = _description;
    map['difficulty'] = _difficulty;
    map['category'] = _category;
    return map;
  }

}