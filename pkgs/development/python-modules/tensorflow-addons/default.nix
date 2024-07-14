{
  config,
  lib,
  pkgs,
  typeguard,
  buildPythonPackage,
  packaging,
  pythonAtLeast,
  fetchFromGitHub,
  fetchPypi,
  setuptools,
  wheel,
}:

let
  # typeguard>=2.7,<3.0.0 so take the laste
  typeguard_2_13_3 = typeguard.overridePythonAttrs (oldAttrs: rec {
    version = "2.13.3";

    src = fetchPypi {
      pname = "typeguard";
      inherit version;
      hash = "sha256-AO2qjaOhM2dHls9eqH2fS0w2fXdHbhhegCUcwT37uMQ=";
    };

    # 12 tests failed for this late version
    doCheck = false;
  });
in
buildPythonPackage rec {
  pname = "tensorflow-addons";
  version = "0.23.0";

  disabled = pythonAtLeast "3.12";

  src = fetchFromGitHub {
    owner = "tensorflow";
    repo = "addons";
    rev = "v${version}";
    sha256 = "sha256-2tIZsbB33JlSlvJ2QcE1s6l+G0NYt37V+nVII64qduQ=";
  };

  dependencies = [
    typeguard_2_13_3
    packaging
  ];

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
