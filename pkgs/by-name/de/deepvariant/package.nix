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
    # contextlib # TODO replace contextlib2 to contextlib in a patch
    etils
    typing-extensions
    importlib-resources
    enum34
    sortedcontainers
    intervaltree
    mock
    ml-collections
    clu
    # # # Note that protobuf installed with pip needs to be 3.13 because of the pyclif
    # # # version we're using. This is currently inconsistent with C++ protobuf version
    # # # in WORKSPACE and protobuf.BUILD, but we can't update those, because those
    # # # files need to be consistent with what TensorFlow needs, which is currently
    # # # still 3.9.2.
    # # # Ideally we want to make these protobuf versions all match, eventually.
    # # protobuf==3.13.0
    # protobuf
    # # argparse==1.4.0
    # argparse include in python !
    #emerge --update --newuse --deep --with-bdeps=y @world git+https://github.com/google-research/tf-slim.git@v1.1.0
    # "numpy==${DV_TF_NUMPY_VERSION}"
    numpy
  ]);
in

mkShell {
  packages = [
    pyEnv
  ];
}
  # # Reason:
  # # ========== [Wed Dec 11 19:57:32 UTC 2019] Stage 'Install python3 packages' starting
  # # ERROR: pyasn1-modules 0.2.7 has requirement pyasn1<0.5.0,>=0.4.6, but you'll have pyasn1 0.1.9 which is incompatible.
  # pip3 install "${PIP_ARGS[@]}" 'pyasn1<0.5.0,>=0.4.6'
  # pip3 install "${PIP_ARGS[@]}" 'requests>=2.18'
  # pip3 install "${PIP_ARGS[@]}" --ignore-installed 'oauth2client>=4.0.0'
  # pip3 install "${PIP_ARGS[@]}" 'crcmod>=1.7'
  # pip3 install "${PIP_ARGS[@]}" 'six>=1.11.0'
  # pip3 install "${PIP_ARGS[@]}" joblib
  # pip3 install "${PIP_ARGS[@]}" psutil
  # pip3 install "${PIP_ARGS[@]}" --upgrade google-api-python-client
  # pip3 install "${PIP_ARGS[@]}" 'pandas==1.2.4'
  # # We manually install jsonschema here to pin it to v3.2.0, since
  # # the latest v4.0.1 has issues with Altair v4.1.0.
  # # See https://github.com/altair-viz/altair/issues/2496
  # # If Altair version is updated below, the jsonschema version
  # # should also be updated accordingly.
  # pip3 install "${PIP_ARGS[@]}" 'jsonschema==3.2.0'
  # pip3 install "${PIP_ARGS[@]}" 'altair==4.1.0'
  # pip3 install "${PIP_ARGS[@]}" 'Pillow==9.5.0'
  # pip3 install "${PIP_ARGS[@]}" 'ipython>=7.9.0'
  # pip3 install "${PIP_ARGS[@]}" 'pysam==0.20.0'
  # pip3 install "${PIP_ARGS[@]}" 'tensorflow-addons==0.21.0'
  # pip3 install "${PIP_ARGS[@]}"  "tf-models-official==${DV_GCP_OPTIMIZED_TF_WHL_VERSION}"


  # # for htslib
  # sudo -H apt-get install "${APT_ARGS[@]}" libssl-dev libcurl4-openssl-dev liblz-dev libbz2-dev liblzma-dev > /dev/null

  # # for the debruijn graph
  # sudo -H apt-get install "${APT_ARGS[@]}" libboost-graph-dev > /dev/null

  # # Just being safe, pin protobuf's version one more time.
  # pip3 install "${PIP_ARGS[@]}" 'protobuf==3.13.0'


  # TODO replace contextlib2 to contextlib
