{
  config,
  lib,
  pkgs,
  typeguard,
  buildPythonPackage,
  packaging,
  pythonAtLeast,
  fetchPypi,
  setuptools,
  wheel,
  cython,
  pillow,
  gin-config,
  google-api-python-client,
  immutabledict,
  kaggle,
  matplotlib,
  numpy,
  oauth2client,
  opencv4,
  pandas,
  psutil,
  py-cpuinfo,
  pycocotools,
  pyyaml,
  sacrebleu,
  scipy,
  sentencepiece,
  seqeval,
  six,
  tensorflow-datasets,
  # tensorflow-hub,
  # tensorflow-model-optimization,
  tf-keras,
  # tf_slim
}:

buildPythonPackage rec {
  pname = "tf-models-official";
  version = "2.16.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-c6PYAggRnjW4t9R02tRQsn4gqidSnWunKWi1HETdPDg=;";
  };

  dependencies = [
    cython
    pillow
    gin-config
    google-api-python-client
    immutabledict
    kaggle
    matplotlib
    numpy
    oauth2client
    opencv4
    pandas
    psutil
    py-cpuinfo
    pycocotools
    pyyaml
    sacrebleu
    scipy
    sentencepiece
    seqeval
    six
    tensorflow-datasets
    # tensorflow-hub
    # tensorflow-model-optimization
    tf-keras
    # tf_slim
  ];

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}
