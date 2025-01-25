{
  lib,
  stdenv,
  fetchurl,
  buildPythonPackage,
  python,
  setuptools,
  wheel,
  tensorflow,
  pytest,
}:

buildPythonPackage rec {
  pname = "tensorflow-hub";
  version = "0.16.1";

  format = "wheel";

  deps = [
    tensorflow
  ];
  src = fetchurl {
    inherit pname version;
    url = "https://files.pythonhosted.org/packages/e5/50/00dba77925bf2a0a1e45d7bcf8a69a1d2534fb4bb277d9010bd148d2235e/tensorflow_hub-${version}-py2.py3-none-any.whl";
    hash = "sha256-4QwYSz0I2ur62hH/6i3UZ4FyW2vvAfrR901mNK0FMR8=";
  };

}
