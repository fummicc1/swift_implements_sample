import Foundation

protocol A {
    func configure()
}

protocol B {
    func configure()
}

class C: A, B {
    @_implements(A, configure())
    func configureA() {
        print("A is cofigured!")
    }

    @_implements(B, configure())
    func configureB() {
        print("B is configured!")
    }
}

let c: A = C()
c.configure()

protocol IncrementalIDGenerator {
    func make() -> String
}

protocol RandomIDGenerator {
    func make() -> String
}

class IDGenerator: IncrementalIDGenerator, RandomIDGenerator {

    private var count: Int = 0

    @_implements(IncrementalIDGenerator, make())
    func makeIncremental() -> String {
        count += 1
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 32
        return formatter.string(for: count)!
    }

    @_implements(RandomIDGenerator, make())
    func makeRandom() -> String {
        count += 1
        return (0..<32)
            .map { _ in Int.random(in: 0...9) }
            .map { String($0) }
            .joined(separator: "")
    }
}

let generator: IncrementalIDGenerator = IDGenerator()
print(generator.make())
