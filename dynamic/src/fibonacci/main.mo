import Layer "Layer";
import Fibonacci "Fibonacci";

import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor class Reader() {
  type Valuer = { value: () -> Nat };
  type Saver = { save: Nat -> ()};

  var fib = Fibonacci.Fibonacci();
  var layer = Layer.Blob();

  public func read() : async Nat {
    let v : Valuer = fib;
    let s : Saver = fib;

    switch (layer.load()) {
      case (?text) {
        Debug.print("Stored memory (" # text # ")");
      };
      case null {};
    };

    var result = 0;

    for (i in Iter.range(0, 2)) {
      result := v.value();
      s.save(result);
    };

    layer.store(Nat.toText(result));
    return result;
  };

  public func reset() {
    fib.reset();
  };

  system func heartbeat() : async () {
    Debug.print("Beat (" # Nat.toText(fib.value()) # ")");
  };
};
