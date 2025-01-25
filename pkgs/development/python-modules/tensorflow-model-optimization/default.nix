
{
  buildPythonPackage,
  fetchFromGitHub,
  ftfy,
  langcodes,
  msgpack,
  regex,
  setuptools,
  wheel,
  absl-py,
  poetry-core,
    numpy,
    six,
    scipy,
    enum34,
    mock,
    dm-tree,
    tf-keras,
}:

buildPythonPackage rec {
  pname = "tensorflow-model-optimization";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "tensorflow";
    repo = "model-optimization";
    tag = "v${version}";
    hash = "sha256-ANOBbQWLB35Vz6oil6QZDpsNpKHeKUJnDKA5Q9JRVdE=";
  };

  dependencies = [
    absl-py #>=1.2.0
    numpy #~=1.23.0
    six #~=1.14
    scipy
    enum34 #~=1.1
    mock
    poetry-core
    dm-tree #~=0.1.1
    tf-keras #>=2.14.1
    ftfy

  langcodes
  msgpack
  regex
  ];

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
