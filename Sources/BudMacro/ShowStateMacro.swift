//
//  ShowStateMacro.swift
//  BudMacro
//
//  Created by 김민우 on 7/15/25.
//


/// 타입의 인스턴스 프로퍼티 이름을 값으로 갖는 정적(static) 문자열 프로퍼티를 자동으로 생성합니다.
///
/// 이 매크로는 적용된 타입의 각 프로퍼티를 순회하며, 해당 프로퍼티와 동일한 이름의 `static let` 상수를 추가합니다.
/// 이 상수의 값은 프로퍼티의 이름(String)입니다. 이를 통해 코드 내에서 "매직 스트링(magic string)" 사용을 방지하고
/// 컴파일 타임에 오타를 확인할 수 있어 코드의 안정성을 크게 향상시킵니다.
///
/// ### 주요 사용처
/// * Firestore 필드 이름
/// * JSON 키
/// * `UserDefaults` 키
/// * `KVO(Key-Value Observing)` 경로
///
/// ### 사용 예시
/// 매크로를 타입에 적용하면 컴파일러가 다음과 같이 코드를 확장합니다.
/// ```swift
/// // 매크로 적용 전
/// @ShowState
/// struct User {
///     var id: String
///     var nickname: String
/// }
///
/// // 매크로 확장 후 (컴파일러가 생성하는 코드)
/// struct User {
///     var id: String
///     var nickname: String
///
///     static let id: String = "id"
///     static let nickname: String = "nickname"
/// }
/// ```
///
/// ### 실제 활용
/// 생성된 정적 프로퍼티를 사용하여 타입 안전성을 확보할 수 있습니다.
/// ```swift
/// // 👎 나쁜 예: "매직 스트링" 사용 (오타 시 런타임에 의도치 않은 동작 발생)
/// db.collection("users").updateData(["naickname": "새 닉네임"])
///
/// // 👍 좋은 예: @ShowState로 생성된 프로퍼티 사용 (오타 시 컴파일 오류 발생)
/// db.collection("users").updateData([User.nickname: "새 닉네임"])
/// ```
///
/// - Note: 이 매크로는 `@attached(member)`로 동작하며, `names: arbitrary`를 통해
///   타입의 프로퍼티 이름에 기반한 새로운 멤버를 자유롭게 추가할 수 있습니다.
@attached(member, names: arbitrary)
public macro ShowState() = #externalMacro(module: "BudMacroCore", type: "ShowStateMacro")
