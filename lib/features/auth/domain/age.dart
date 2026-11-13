/// Whole years from [birthday] to [today]. The year counts only once the
/// birthday has come round, so someone born on 1 May is still 12 on
/// 30 April of the year they turn 13.
int ageOn({required DateTime today, required DateTime birthday}) {
  final hadBirthdayThisYear =
      today.month > birthday.month ||
      (today.month == birthday.month && today.day >= birthday.day);
  return today.year - birthday.year - (hadBirthdayThisYear ? 0 : 1);
}
