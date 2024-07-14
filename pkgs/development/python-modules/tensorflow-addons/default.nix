{
  config,
  lib,
  pkgs,
  typeguard
  buildPythonPackage,
  packaging,
  pythonAtLeast,
  fetchPypi,
  setuptools,
  wheel,
}:

buildPythonPackage rec {
  pname = "tensorflow-addons";
  version = "0.23.0";

  disabled = pythonAtLeast "3.12";

  src = fetchPypi {
    inherit pname version;
    hash = ""; #sha256-9x6qGvvTD1f3cJJXun4f64rVwcPcrjYGZyoThni7POQ=";
  };

  dependencies = [
    typeguard
    packaging
  ];

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
