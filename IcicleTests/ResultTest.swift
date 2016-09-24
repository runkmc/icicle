
import Foundation
import XCTest
@testable import Icicle

class ResultTest: XCTestCase {

    struct TestUser {
        let name: String
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
    
    func testFiltering() {
        let tu1: Result<String, TestUser> = .success(TestUser(name: "James Kirk"))
        let tu2: Result<String, TestUser> = .success(TestUser(name: "Jean-Luc Picard"))
        let fail: Result<String, TestUser> = .error("no user")
        let list = [tu1, tu2, fail]
        
        XCTAssertEqual(Result.errors(list).count, 1)
        XCTAssertEqual(Result.successes(list).count, 2)
    }
    
    func testGettingValues() {
        let tu1: Result<String, TestUser> = .success(TestUser(name: "James Kirk"))
        let fail: Result<String, TestUser> = .error("no user")
        
        XCTAssertEqual(tu1.successValue()!.name, "James Kirk")
        XCTAssertEqual(fail.errorValue()!, "no user")
    }
    
    func testMap() {
        let tu1: Result<String, String> = .success("James Kirk")
        let result: Result<String, TestUser> = tu1.map { name in TestUser(name: name) }
        XCTAssertEqual(result.successValue()!.name, "James Kirk")
        
        let fail: Result<String, String> = .error("no user")
        let failResult: Result<String, TestUser> = fail.map { name in TestUser(name: name) }
        XCTAssertEqual(failResult.errorValue()!, "no user")
    }
    
    func testFlatMap() {
        func flatMapTest(str:String) -> Result<String, [String]> {
            return .success([str, "and another string"])
        }
        
        let s: Result<String, String> = .success("yes!")
        let successResult = s.flatMap(flatMapTest)
        XCTAssertEqual(successResult.successValue()!, ["yes!", "and another string"])
        
        let f: Result<String, String> = .error("no!")
        let failResult = f.flatMap(flatMapTest)
        XCTAssertEqual(failResult.errorValue()!, "no!")
    }

    func testFlatMapOperator() {
        func flatMapTest(str:String) -> Result<String, [String]> {
            return .success([str, "and another string"])
        }
    
        let s: Result<String, String> = .success("yes!")
        let successResult = s >>- flatMapTest
        XCTAssertEqual(successResult.successValue()!, ["yes!", "and another string"])
    }

}
