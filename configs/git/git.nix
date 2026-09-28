{
  pkgs,
  ...
}:

let
  gitconfig = pkgs.writeShellApplication {
    name = "gitconfig";
    runtimeInputs = [ pkgs.git ];
    text = ''
      case "''${1-}" in
        azuolasma)
          name=azuolasma
          email=azuolas.majauskas@mif.stud.vu.lt
          ;;
        azumawin)
          name=azumawin
          email=azuolas004@gmail.com
          ;;
        *)
          echo "usage: gitconfig {azuolasma|azumawin}" >&2
          exit 1
          ;;
      esac

      git config user.name "$name"
      git config user.email "$email"
      echo "$name <$email>"
    '';
  };
in

{

  home.file.".gitconfig".source = ./config/.gitconfig;
  home.packages = [
    pkgs.git
    gitconfig
  ];
}
