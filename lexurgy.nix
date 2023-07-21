{ lib
, stdenv
, fetchurl
, jre_minimal
, jdk
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "lexurgy";
  version = "1.2.2";

  src = fetchurl {
    url = "https://github.com/def-gthill/lexurgy/releases/download/v${version}/lexurgy-${version}.tar";
    sha256 = "sha256-nSKgIYIzOimzjnyW3GrRelniBgKeZUx6kKCZWqoCqXU=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  unpackCmd = "tar xvf $curSrc";

  #Need to specify full classPath found in CLASSPATH variable of $out/bin/lexurgy
  classPath = "$out/lib/${pname}-${version}.jar:$out/lib/clikt-jvm-2.7.0.jar:$out/lib/kotlin-stdlib-jdk8-1.7.20.jar:$out/lib/kotlin-stdlib-jdk7-1.7.20.jar:$out/lib/kotlin-stdlib-1.7.20.jar:$out/lib/kotlin-stdlib-common-1.7.20.jar:$out/lib/antlr4-runtime-4.7.2.jar:$out/lib/jna-platform-5.5.0.jar:$out/lib/jna-5.5.0.jar:$out/lib/annotations-13.0.jar";

  #Only want lexurgy and not lexurgy.bat
  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp -r bin/${pname} $out/bin/${pname}
    cp -r lib/* $out/lib
    makeWrapper ${jre_minimal}/bin/java $out/bin/${pname} \
      --add-flags "-cp ${classPath} com.meamoria.lexurgy.MainJvmKt" \
      --set JAVA_HOME ${jdk.home}
  '';

  meta = with lib; {
    description = "Lexurgy is a sound change applier";
    longDescription = ''
      Lexurgy is a sound change applier. It allows the user to simulate historical
      changes in spoken languages by applying regular rules to a list of words.
    '';
    homepage = "https://github.com/def-gthill/lexurgy";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ scotabroad ];
  };
}
