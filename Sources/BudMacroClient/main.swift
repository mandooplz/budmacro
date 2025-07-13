import BudMacro
import Foundation

let (logger, log) = WorkFlow.logging(for: "Mandoo")

await WorkFlow {
    #success
    #success("Success Reason")
    
    #failure
    #failure("Falure!!")
    
    #critical
    #critical("Citical!!")
}
