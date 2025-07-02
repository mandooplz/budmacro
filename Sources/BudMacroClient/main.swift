import BudMacro
import Observation
import Foundation

protocol SampleProtocol {
    var name: String { get }
    var age: Int { get }
}

@ClientObject
final class Mandoo { }
