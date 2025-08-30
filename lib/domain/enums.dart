enum GuardPostDifficulty {
  easy, // ساده
  medium, // متوسط
  hard, // سخت
}

enum Priority { unimportant, veryLow, low, medium, high, veryHigh, absolute }

enum MilitaryRank {
  // Enlisted (سربازان و درجه‌داران)
  private, // سرباز وظیفه
  private1Class, // سرباز دوم
  private2Class, // سرباز یکم
  lanceCorporal, // سرجوخه
  sergeant3, // گروهبان سوم
  sergeant2, // گروهبان دوم
  sergeant1, // گروهبان یکم
  warrantOfficer2, // استوار دوم
  warrantOfficer1, // استوار یکم
  // Officers (افسران)
  secondLieutenant, // ستوان سوم
  firstLieutenant, // ستوان دوم
  seniorLieutenant, // ستوان یکم
  captain, // سروان
  major, // سرگرد
  lieutenantColonel, // سرهنگ دوم
  colonel, // سرهنگ
  // General Officers (امیران)
  brigadierGeneral, // سرتیپ دوم
  majorGeneral, // سرتیپ
  lieutenantGeneral, // سرلشکر
  general, // سپهبد
  generalOfArmy, // ارتشبد
}

extension MilitaryRankExtension on MilitaryRank {
  String get faName {
    switch (this) {
      case MilitaryRank.private:
        return "سرباز وظیفه";
      case MilitaryRank.private1Class:
        return "سرباز دوم";
      case MilitaryRank.private2Class:
        return "سرباز یکم";
      case MilitaryRank.lanceCorporal:
        return "سرجوخه";
      case MilitaryRank.sergeant3:
        return "گروهبان سوم";
      case MilitaryRank.sergeant2:
        return "گروهبان دوم";
      case MilitaryRank.sergeant1:
        return "گروهبان یکم";
      case MilitaryRank.warrantOfficer2:
        return "استوار دوم";
      case MilitaryRank.warrantOfficer1:
        return "استوار یکم";

      case MilitaryRank.secondLieutenant:
        return "ستوان سوم";
      case MilitaryRank.firstLieutenant:
        return "ستوان دوم";
      case MilitaryRank.seniorLieutenant:
        return "ستوان یکم";
      case MilitaryRank.captain:
        return "سروان";
      case MilitaryRank.major:
        return "سرگرد";
      case MilitaryRank.lieutenantColonel:
        return "سرهنگ دوم";
      case MilitaryRank.colonel:
        return "سرهنگ";

      case MilitaryRank.brigadierGeneral:
        return "سرتیپ دوم";
      case MilitaryRank.majorGeneral:
        return "سرتیپ";
      case MilitaryRank.lieutenantGeneral:
        return "سرلشکر";
      case MilitaryRank.general:
        return "سپهبد";
      case MilitaryRank.generalOfArmy:
        return "ارتشبد";
    }
  }

  String get enName {
    switch (this) {
      case MilitaryRank.private:
        return "Private";
      case MilitaryRank.private1Class:
        return "Private Second Class";
      case MilitaryRank.private2Class:
        return "Private First Class";
      case MilitaryRank.lanceCorporal:
        return "Lance Corporal";
      case MilitaryRank.sergeant3:
        return "Sergeant Third Class";
      case MilitaryRank.sergeant2:
        return "Sergeant Second Class";
      case MilitaryRank.sergeant1:
        return "Sergeant First Class";
      case MilitaryRank.warrantOfficer2:
        return "Warrant Officer 2";
      case MilitaryRank.warrantOfficer1:
        return "Warrant Officer 1";

      case MilitaryRank.secondLieutenant:
        return "Second Lieutenant";
      case MilitaryRank.firstLieutenant:
        return "First Lieutenant";
      case MilitaryRank.seniorLieutenant:
        return "Senior Lieutenant";
      case MilitaryRank.captain:
        return "Captain";
      case MilitaryRank.major:
        return "Major";
      case MilitaryRank.lieutenantColonel:
        return "Lieutenant Colonel";
      case MilitaryRank.colonel:
        return "Colonel";

      case MilitaryRank.brigadierGeneral:
        return "Brigadier General";
      case MilitaryRank.majorGeneral:
        return "Major General";
      case MilitaryRank.lieutenantGeneral:
        return "Lieutenant General";
      case MilitaryRank.general:
        return "General";
      case MilitaryRank.generalOfArmy:
        return "General of the Army";
    }
  }
}

enum ConscriptionStage {
  recruit, // تازه وارد (دوره آموزشی یا ماه‌های اول)
  junior, // سرباز تازه وارد به یگان (تجربه کم)
  intermediate, // سرباز میان‌خدمتی (چند ماه خدمت کرده)
  senior, // سرباز قدیمی (نزدیک به پایان خدمت)
  discharged, // ترخیص شده
}

extension ConscriptionStageExtension on ConscriptionStage {
  String get faName {
    switch (this) {
      case ConscriptionStage.recruit:
        return "تازه‌وارد / آموزشی";
      case ConscriptionStage.junior:
        return "سرباز تازه‌وارد به یگان";
      case ConscriptionStage.intermediate:
        return "میان‌خدمتی";
      case ConscriptionStage.senior:
        return "پایان‌خدمتی";
      case ConscriptionStage.discharged:
        return "ترخیص شده";
    }
  }

  String get enName {
    switch (this) {
      case ConscriptionStage.recruit:
        return "Recruit / Training";
      case ConscriptionStage.junior:
        return "Junior Soldier";
      case ConscriptionStage.intermediate:
        return "Intermediate Soldier";
      case ConscriptionStage.senior:
        return "Senior Soldier";
      case ConscriptionStage.discharged:
        return "Discharged";
    }
  }
}

enum PostPolicyType {
  leave,
  friendSoldiers,
  weekOffDays,
  noNightNNight,
  noNight1Night,
  noNight2Night,
  minPostCount,
  maxPostCount,
  noWeekendPerMonth,
  equalHolidayPost,
  equalPostDifficulty;

  String get title => switch (this) {
    leave => "مرخصی",
    friendSoldiers => "دوستان سربازان",
    weekOffDays => "روزهای خاموش",
    noNightNNight => "بدون شب",
    noNight1Night => "بدون شب یک",
    noNight2Night => "بدون شب دو",
    minPostCount => "حداقل تعداد پست",
    maxPostCount => "حداکثر تعداد پست",
    noWeekendPerMonth => "بدون هفته در ماه",
    equalHolidayPost => "تعداد پست هفتگی",
    equalPostDifficulty => "سختی پست هفتگی",
  };
}

enum EditType { manual, auto }
