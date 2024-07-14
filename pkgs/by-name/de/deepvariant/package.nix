{ config, lib, pkgs
, mkShell
, python311 }:


# Source: https://github.com/google/deepvariant/blob/r1.6.1/run-prereq.sh
# If we want contextlib2, it forces us to use python3.10. Then python3.10-jax is not fetched
# from the cache and crashes during tests (not enough RAM).
# We try to replace contextlib2 to contextlib (thanks @K900 on Element)
let
    #--- Python 3.11 while waiting for tensorflow to support 3.12
  pyEnv = python311.withPackages (ps: with ps; [
    altair
    clu
    crcmod
    enum34
    etils
    google-api-python-client
    importlib-resources
    intervaltree
    ipython
    joblib
    jsonschema
    ml-collections
    mock
    numpy
    oauth2client
    pandas
    pillow
    protobuf
    psutil
    pyasn1
    pysam
    requests
    six
    sortedcontainers
    # tensorflow-addons TODO
    # tf-models-official TODO
    typing-extensions
  ]);
in

mkShell {
  packages = [
    pyEnv
  ];
}


  # # for htslib
  # sudo -H apt-get install "${APT_ARGS[@]}" libssl-dev libcurl4-openssl-dev liblz-dev libbz2-dev liblzma-dev > /dev/null

  # # for the debruijn graph
  # sudo -H apt-get install "${APT_ARGS[@]}" libboost-graph-dev > /dev/null

  # TODO replace contextlib2 to contextlib
