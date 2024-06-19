{ config, lib, pkgs
,    absl-py
,    etils
,    flax
,    jax
,    jaxlib
,    ml-collections
,    numpy
,    typing-extensions
,    wrapt
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "clu";
  version = "0.0.12";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-9x6qGvvTD1f3cJJXun4f64rVwcPcrjYGZyoThni7POQ=";
  };

  dependencies = [
    absl-py
    etils
    flax
    jax
    jaxlib
    ml-collections
    numpy
    typing-extensions
    wrapt
  ];

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
