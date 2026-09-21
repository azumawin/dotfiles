{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "hashcards";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "eudoxia0";
    repo = "hashcards";
    rev = "v${version}";
    hash = "sha256-KkQwSoLvaiEckyBCryRevUq1HIVZNtBhctEBcfKKHw0=";
  };

  cargoHash = "sha256-qd0cmxiHilyMHSMrX58OMrFANDTT+OCBsCYDbf++BTM=";

  # disable tests on build, just trust
  doCheck = false;

  meta = {
    description = "Plain text-based spaced repetition system";
    homepage = "https://github.com/eudoxia0/hashcards";
    license = lib.licenses.asl20;
    mainProgram = "hashcards";
  };
}
