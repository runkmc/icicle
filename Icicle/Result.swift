infix operator >>-
infix operator <^>

public enum Result<E, S> {
    case error(E)
    case success(S)
    
    public static func isSuccess(_ item:Result<E, S>) -> Bool {
        if case .success = item { return true }
        return false
    }

    public static func isError(_ item:Result<E, S>) -> Bool {
        return !isSuccess(item)
    }
    
    public func successValue() -> S? {
        switch self {
        case .success(let value): return value
        default: return nil
        }
    }
    
    public func errorValue() -> E? {
        switch self {
        case .error(let value): return value
        default: return nil
        }
    }
    
    public static func errors(_ items:[Result<E, S>]) -> [Result<E, S>] {
        return items.filter {isError($0) }
    }
    
    public static func successes(_ items:[Result<E, S>]) -> [Result<E, S>] {
        return items.filter {isSuccess($0) }
    }

    public func map<V>(_ f:(S)->V) -> Result<E, V> {
        switch self {
        case let .success(x): return .success(f(x))
        case let .error(x):  return .error(x)
        }
    }
    
    public func flatMap<V>(_ f:(S)->Result<E, V>) -> Result<E, V> {
        switch self {
        case let .success(x): return f(x)
        case let .error(x): return .error(x)
        }
    }
    
    static public func >>-<V>(result:Result<E, S>, f:(S)->Result<E, V>) -> Result<E, V> {
        return result.flatMap(f)
    }
    
    static public func <^><V>(result:Result<E, S>, f:(S)->V) -> Result<E, V> {
        return result.map(f)
    }
}
