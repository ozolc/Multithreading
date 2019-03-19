import UIKit

var str = "Lock"

class ReadWriteLock {
    
    private func address(o: UnsafeRawPointer) -> Int {
        return Int(bitPattern: o)
    }
    
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()
    
    private var globalProperty: Int = 0
    
    init() {
        pthread_rwlock_init(&lock, &attribute)
    }
    
    public var workProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            print(NSString(format: "%p", address(o: &self.globalProperty)))
            
            var temp = globalProperty
            print(NSString(format: "%p", address(o: &temp)))
            pthread_rwlock_unlock(&lock)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

let cl01 = ReadWriteLock()
cl01.workProperty

class UnfairLock {
    private var lock = os_unfair_lock_s()
    
    var array = [Int]()
    
    func some() {
        os_unfair_lock_lock(&lock)
        array.append(1)
        os_unfair_lock_unlock(&lock)
    }
}

class SynchronizedObjc {
    private let lock = NSObject()
    
    var array = [Int]()
    
    func some() {
        objc_sync_enter(lock)
        array.append(1)
        objc_sync_exit(lock)
    }
}
