{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "blackglass-theme";
  version = "4.1";

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plasma/desktoptheme
    tar xzf ${../resources/blackglass/blackglass.plasmastyle.tar.gz} \
      -C $out/share/plasma/desktoptheme

    runHook postInstall
  '';

  meta = {
    description = "Black Glass Plasma style for KDE Plasma 6 (Mark Whittaker)";
    license = lib.licenses.gpl2Plus; # metadata.desktop says GPL-2.0+, bundled LICENSE is GPLv3
    platforms = lib.platforms.linux;
  };
}
