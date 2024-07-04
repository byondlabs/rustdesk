#!/usr/bin/env bash
set -ex

cargo install flutter_rust_bridge_codegen --version 1.80.1 --features uuid
flutter pub get

~/.cargo/bin/flutter_rust_bridge_codegen --rust-input ../src/flutter_ffi.rs --dart-output ./lib/generated_bridge.dart --c-output ./macos/Runner/bridge_generated.h

# call `flutter clean` if cargo build fails
# export LLVM_HOME=/Library/Developer/CommandLineTools/usr/
# cargo build --features flutter
#
# r-byondlabs: taken from github-build
# MACOSX_DEPLOYMENT_TARGET=10.14 cargo build --features flutter --lib --release
MACOSX_DEPLOYMENT_TARGET=10.14 cargo build --features flutter --lib
# copy dylib
cp ../target/debug/liblibrustdesk.dylib ../target/release/liblibrustdesk.dylib

flutter run $@
