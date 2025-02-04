{ tectonic-unwrapped, fetchFromGitHub }:
tectonic-unwrapped.override (old: {
  rustPlatform = old.rustPlatform // {
    buildRustPackage =
      args:
      old.rustPlatform.buildRustPackage (
        args
        // {
          pname = "texpresso-tonic";
          src = fetchFromGitHub {
            owner = "let-def";
            repo = "tectonic";
            rev = "5b844105c06e0b16e40b1254359f8c28e8956280";
            hash = "sha256-RPsXmp+5MF9h+H3wdL1O1hXSRZWjWTY8lXq/dWZIM1g=";
            fetchSubmodules = true;
          };
          cargoHash = "sha256-mqhbIv5r/5EDRDfP2BymXv9se2NCKxzRGqNqwqbD9A0=";
          # binary has a different name, bundled tests won't work
          doCheck = false;
          meta.mainProgram = "texpresso-tonic";
        }
      );
  };
})
