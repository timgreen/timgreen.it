ROOT_DIR=$(readlink -f $(dirname "$0")/../)
cd "$ROOT_DIR"

calc_source() {
  ENTRY_POINT="$1"

  python "$ROOT_DIR/tools/google-closure-library/current/closure/bin/build/closurebuilder.py" \
    -c "$ROOT_DIR/tools/google-closure-compiler/compiler.jar" \
    --root "$ROOT_DIR/tools/google-closure-library/current/closure/goog" \
    --root "$ROOT_DIR/tools/google-closure-library/current/third_party/closure/goog/" \
    --root "$ROOT_DIR/content/assets/js/" \
    --input $ENTRY_POINT
}

build() {
  calc_source "$ROOT_DIR/content/assets/js/it/timgreen/Launcher.js" |\
    sed "s/^/--js=/" | xargs \
    java -jar "$ROOT_DIR/tools/google-closure-compiler/compiler.jar" \
      --compilation_level=ADVANCED_OPTIMIZATIONS \
      --output_wrapper="(function(){%output%})();" \
      --process_closure_primitives \
      --summary_detail_level=2 \
      --warning_level=VERBOSE \
      --jscomp_error=accessControls \
      --jscomp_error=ambiguousFunctionDecl \
      --jscomp_error=checkDebuggerStatement \
      --jscomp_error=checkRegExp \
      --jscomp_error=checkVars \
      --jscomp_error=const \
      --jscomp_error=constantProperty \
      --jscomp_error=deprecated \
      --jscomp_error=duplicate \
      --jscomp_error=externsValidation \
      --jscomp_error=fileoverviewTags \
      --jscomp_error=globalThis \
      --jscomp_error=internetExplorerChecks \
      --jscomp_error=invalidCasts \
      --jscomp_error=missingProperties \
      --jscomp_error=nonStandardJsDocs \
      --jscomp_error=strictModuleDepCheck \
      --jscomp_error=undefinedNames \
      --jscomp_error=undefinedVars \
      --jscomp_error=unknownDefines \
      --jscomp_error=uselessCode \
      --jscomp_error=visibility \
      --closure_entry_point=it.timgreen.Launcher \
      #--js_output_file="$ROOT_DIR/content/assets/compiled.js"
      #--jscomp_error=checkTypes \
      #--formatting=PRETTY_PRINT \
}

build
