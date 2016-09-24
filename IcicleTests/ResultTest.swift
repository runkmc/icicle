
import Foundation
import XCTest
@testable import Icicle

class ResultTest: XCTestCase {

    struct TestUser {
        let name: String
    }
    
    static func flatMapTest(str:String) -> Result<String, [String]> {
        return .success([str, "and another string"])
    }
    
    func testSuccessAndErrorChecks() {
        let testUser = TestUser(name:"Montgomery Scott")
        let success: Result<String, TestUser> = .success(testUser)
        let error: Result<String, TestUser> = .error("no such user")
        
        XCTAssertTrue(Result.isSuccess(success))
        XCTAssertFalse(Result.isSuccess(error))
        XCTAssertTrue(Result.isError(error))
        XCTAssertFalse(Result.isError(success))
    }            
//             it("provides lefts and rights") {
//                 let user1: Either<String, String> = .Right("James Kirk")
//                 let user2: Either<String, String> = .Right("William Riker")
//                 let failure: Either<String, String> = .Left("No such user")
//                 let list: [Either<String, String>] = [user1, user2, failure]
                
//                 expect(Either.rights(list)).to(haveCount(2))
//                 expect(Either.lefts(list)).to(haveCount(1))
                
//                 switch (Either.rights(list)[0]) {
//                 case let (.Right(value)) : expect(value) == "James Kirk"
//                 default: fatalError()
//                 }
                
//                 switch (Either.rights(list)[1]) {
//                 case let (.Right(value)) : expect(value) == "William Riker"
//                 default: fatalError()
//                 }
                
//                 switch (Either.lefts(list)[0]) {
//                 case let (.Left(value)) : expect(value) == "No such user"
//                 default: fatalError()
//                 }
//             }
            
//             it("provides Right values") {
//                 let data: Either<String, User> = .Right(testUser)
                
//                 expect(data.rightValue()!.name) == "Montgomery Scott"
//             }
            
//             it("provides Left values") {
//                 let data: Either<String, User> = .Left("no such user")
                
//                 expect(data.leftValue()!) == "no such user"
//             }
            
//             it("maps Right values") {
//                 let data: Either<String, String> = .Right("James Kirk")
//                 let result = data.map { name in User.init(name: name) }
                
//                 switch(result) {
//                 case let .Right(user): expect(user.name) == "James Kirk"
//                 default: fatalError()
//                 }
//             }
            
//             it("leaves left values alone during map") {
//                 let data: Either<String, String> = .Left("a terrible error")
//                 let result = data.map { n in Int(n)! }
                
//                 switch(result) {
//                 case let .Left(x): expect(x) == "a terrible error"
//                 default: fatalError()
//                 }
//             }
            
//             it("flatMaps right values") {
//                 let e: Either<String, String> = .Right("whatever")
//                 let result = e.flatMap(EitherSpec.flatMapTest)
                
//                 switch result {
//                 case let .Right(arr): expect(arr) == ["whatever", "and another string"]
//                 default: fatalError()
//                 }
//             }
            
//             it("leaves left values alone during flatMap") {
//                 let e: Either<String, String> = .Left("whatever")
//                 let result = e.flatMap(EitherSpec.flatMapTest)
                
//                 switch result {
//                 case let .Left(error): expect(error) == "whatever"
//                 default: fatalError()
//                 }
//             }
            
//             it("uses >>- for flatMap") {
//                 let e: Either<String, String> = .Right("whatever")
//                 let result = e >>- EitherSpec.flatMapTest
                
//                 switch result {
//                 case let .Right(arr): expect(arr) == ["whatever", "and another string"]
//                 default: fatalError()
//                 }
//             }
//         }
//     }

}
