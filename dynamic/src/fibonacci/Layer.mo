import StableMemory "mo:base/ExperimentalStableMemory";
import Text "mo:base/Text";
import Nat64 "mo:base/Nat64"

module {
  public class Blob() {
    var offset : Nat64 = 0;
    var size = 0;

    func grow(size : Nat) {
      let pages = (offset + Nat64.fromNat(size)) >> 16 + 1;

      if (pages > StableMemory.size()) {
        ignore StableMemory.grow(pages - StableMemory.size());
      };
    };

    public func store(t : Text) {
      let blob = Text.encodeUtf8(t);
      grow(blob.size());
      StableMemory.storeBlob(offset, blob);
      ignore size := blob.size();
    };

    public func load() : ?Text {
      if (size == 0) {
        return null;
      };

      let blob = StableMemory.loadBlob(offset, size);
      Text.decodeUtf8(blob);
    };
  };
}
