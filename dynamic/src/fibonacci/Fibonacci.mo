module {
  public class Fibonacci() {
    var previous = 0;
    var current = 1;

    public func value() : Nat {
      return current + previous;
    };

    public func save(n : Nat) {
      previous := current;
      current := n;
    };

    public func reset() {
      previous := 0;
      current := 1;
    }
  };
}
