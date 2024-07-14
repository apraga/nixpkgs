{
  config,
  lib,
  pkgs,
  absl-py,
  etils,
  flax,
  jax,
  jaxlib,
  ml-collections,
  numpy,
  typing-extensions,
  wrapt,
  buildPythonPackage,
  pythonAtLeast,
  fetchPypi,
  setuptools,
  wheel,
}:

buildPythonPackage rec {
  pname = "clu";
  version = "0.0.12";

  #--- Python 3.11 while waiting for tensorflow to support 3.12
  disabled = pythonAtLeast "3.12";

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

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
