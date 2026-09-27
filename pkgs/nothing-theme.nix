{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "nothing-theme";
  version = "1.8";

  # Three separate tarballs, two of which both unpack to ./Nothing,
  # so unpack each one explicitly instead of using src/srcs.
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/color-schemes
    tar xzf ${../resources/nothing-theme/Nothing.colors.tar.gz} \
      -C $out/share/color-schemes

    mkdir -p $out/share/plasma/desktoptheme
    tar xzf ${../resources/nothing-theme/Nothing.plasmastyle.tar.gz} \
      -C $out/share/plasma/desktoptheme

    mkdir -p $out/share/aurorae/themes
    tar xzf ${../resources/nothing-theme/Nothing.aurorae.tar.gz} \
      -C $out/share/aurorae/themes

    runHook postInstall
  '';

  meta = {
    description = "Nothing global theme components for KDE Plasma 6 (jomada)";
    homepage = "https://store.kde.org/p/2116667";
    license = with lib.licenses; [
      gpl3Plus
      lgpl21Plus
    ];
    platforms = lib.platforms.linux;
  };
}
