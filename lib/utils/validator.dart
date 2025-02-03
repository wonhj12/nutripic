/// 이메일 유효성 검사
String? Function(String?) emailValidator() {
  return (String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (value == null || value.trim().isEmpty) {
      return '이메일을 입력하세요.';
    }

    if (!emailRegex.hasMatch(value.trim())) {
      return '유효하지 않은 이메일 주소입니다.';
    }

    return null;
  };
}

/// 비밀번호 유효성 검사
String? Function(String?) passwordValidator() {
  return (String? value) {
    final passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (value == null || value.trim().isEmpty) {
      return '비밀번호를 입력하세요.';
    }

    if (!passwordRegex.hasMatch(value.trim())) {
      return '유효하지 않은 비밀번호입니다.';
    }

    return null;
  };
}

/// 이름 유효성 검사
String? Function(String?) nameValidator() {
  return (String? value) {
    // 숫자로 시작 불가, 특수 문자 사용 불가, 2자 이상
    // 한글 초성 및 모음 불가
    final nameRegex = RegExp(r'^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,}$');

    if (value == null || value.trim().isEmpty) {
      return '이름을 입력하세요.';
    }

    if (!nameRegex.hasMatch(value.trim())) {
      return '올바른 이름을 입력하세요.';
    }

    return null;
  };
}
