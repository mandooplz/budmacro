

/// 성공적인 작업 완료를 기록하는 디버그 레벨 로그를 생성합니다.
///
/// 이 매크로를 사용하기 전에 반드시 현재 스코프 내에 `logger`와 `log` 상수가 선언되어 있어야 합니다.
/// 일반적으로 다음과 같은 코드가 선행되어야 합니다.
/// ```
/// let (logger, log) = WorkFlow.logging(for: "MyObjectName")
/// ```
///
/// **사용법:**
/// ```
/// // 기본 성공 로그
/// #success
/// -> [12345678] ✅ Object.Routine success
///
/// // 추가 정보와 함께 성공 로그
/// #success("사용자 데이터 동기화 완료")
/// -> [12345678] ✅ Object.Routine success(사용자 데이터 동기화 완료)
///
/// - Parameter logInfo: (선택 사항) 로그에 포함할 추가적인 정보 문자열입니다.
@freestanding(expression)
public macro success(_ logInfo: String? = nil) = #externalMacro(module: "BudMacroCore", type: "SuccessLogMacro")



/// 작업 실패를 기록하는 에러 레벨 로그를 생성합니다.
///
/// 이 매크로를 사용하기 전에 반드시 현재 스코프 내에 `logger`와 `log` 상수가 선언되어 있어야 합니다.
/// 일반적으로 다음과 같은 코드가 선행되어야 합니다.
/// ```
/// let (logger, log) = WorkFlow.logging(for: "MyObjectName")
/// ```
///
/// **사용법:**
/// ```
/// // 기본 실패 로그
/// #failure
/// -> [12345678] ⚠️ Object.Routine failure
///
/// // 실패 원인과 함께 로그
/// #failure("네트워크 연결 시간 초과")
/// -> [12345678] ⚠️ Object.Routine failure(네트워크 연결 시간 초과)
///
/// - Parameter logInfo: (선택 사항) 로그에 포함할 실패 원인 또는 추가 정보 문자열입니다.
@freestanding(expression)
public macro failure(_ logInfo: String? = nil) = #externalMacro(module: "BudMacroCore", type: "FailureLogMacro")


/// 시스템의 안정성을 해칠 수 있는 심각한 오류를 기록하는 폴트(fault) 레벨 로그를 생성합니다.
///
/// 이 매크로를 사용하기 전에 반드시 현재 스코프 내에 `logger`와 `log` 상수가 선언되어 있어야 합니다.
/// 일반적으로 다음과 같은 코드가 선행되어야 합니다.
/// ```
/// let (logger, log) = WorkFlow.logging(for: "MyObjectName")
/// ```
///
/// **사용법:**
/// ```
/// // 기본 심각한 오류 로그
/// #critical
/// -> [12345678] ❌ Object.Routine critical
///
/// // 오류에 대한 상세 정보와 함께 로그
/// #critical("데이터베이스 파일 손상 감지")
/// -> [12345678] ❌ Object.Routine critical(데이터베이스 파일 손상 감지)
/// ```
///
/// - Parameter logInfo: (선택 사항) 로그에 포함할 오류에 대한 상세 정보 문자열입니다.
@freestanding(expression)
public macro critical(_ logInfo: String? = nil) = #externalMacro(module: "BudMacroCore", type: "CriticalLogMacro")


