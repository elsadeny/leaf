ios:
	cargo lipo --release -p leaf-ffi
	cbindgen --config leaf-ffi/cbindgen.toml leaf-ffi/src/lib.rs > target/universal/release/leaf.h

ios-dev:
	cargo lipo -p leaf-ffi
	cbindgen --config leaf-ffi/cbindgen.toml leaf-ffi/src/lib.rs > target/universal/debug/leaf.h

lib:
	cargo build -p leaf-ffi --release
	cbindgen --config leaf-ffi/cbindgen.toml leaf-ffi/src/lib.rs > target/release/leaf.h

lib-dev:
	cargo build -p leaf-ffi
	cbindgen --config leaf-ffi/cbindgen.toml leaf-ffi/src/lib.rs > target/debug/leaf.h

lib-osx-rosetta:
	cargo build --target x86_64-apple-darwin -p leaf-ffi --release
	cbindgen --config leaf-ffi/cbindgen.toml leaf-ffi/src/lib.rs > target/x86_64-apple-darwin/release/leaf.h

local:
	cargo build -p leaf-bin --release

local-dev:
	cargo build -p leaf-bin

mipsel:
	./misc/build_cross.sh mipsel-unknown-linux-musl

mips:
	./misc/build_cross.sh mips-unknown-linux-musl

test:
	cargo test -p leaf -- --nocapture

# Force a re-generation of protobuf files.
proto-gen:
	touch leaf/build.rs
	PROTO_GEN=1 cargo build -p leaf
