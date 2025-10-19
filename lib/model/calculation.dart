class Calculation {
  final int? id;
  final double mass;
  final double radius;
  final double velocity;

  Calculation({
    this.id,
    required this.mass,
    required this.radius,
    required this.velocity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mass': mass,
      'radius': radius,
      'velocity': velocity,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      id: map['id'],
      mass: map['mass'],
      radius: map['radius'],
      velocity: map['velocity'],
    );
  }
}