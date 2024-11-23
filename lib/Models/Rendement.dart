class Rondement{

  late String date;
  late String value;

  Rondement(
      this.date,
      this.value,
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'value': value,
  };

  Rondement.fromSnapshot(Map<String, dynamic>? snapshot)
      : date = snapshot!['date'],
        value = snapshot['value'];

}