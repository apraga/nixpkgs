{
  lib,
  stdenv,
  fetchurl,
  # fetchFromGitHub,
  # bazel_6,
  # buildBazelPackage,
  buildPythonPackage,
  # cctools,
  python,
  setuptools,
  wheel,
  tensorflow,
  pytest,
}:

# let
#   pname = "tensorflow-hub";
#   version = "0.16.1";

#   # first build all binaries and generate setup.py using bazel
#   bazel-wheel = buildBazelPackage {
#     name = "tensorflow_hub-${version}-py2.py3-none-any.whl";
#     src = fetchFromGitHub {
#       owner = "tensorflow";
#       repo = "hub";
#       rev = "refs/tags/v${version}";
#       hash = "sha256-zrAmzkAUfAJ6cM7ggb1vmJOkXCB/c6SsQrdF805FfCk=";
#     };
#     nativeBuildInputs = [
#       # needed to create the output wheel in installPhase
#       python
#       setuptools
#       wheel
#     ];

#     bazel = bazel_6;

#     bazelTargets = [
#       "//tensorflow_hub/pip_package:build_pip_package"
#     ];

#     # bazelBuildFlags = [" --nofetch "];
#     LIBTOOL = lib.optionalString stdenv.isDarwin "${cctools}/bin/libtool";

#     fetchAttrs = {
#       sha256 = "sha256-NYFAau3s5cx3ygqJEyUsM0FpQ3q8MwzS6tAPmU+M67s=";
#     };


#     buildAttrs = {
#       preBuild = ''
#         patchShebangs .
#       '';


#       installPhase = ''
#         # work around timestamp issues
#         # https://github.com/NixOS/nixpkgs/issues/270#issuecomment-467583872
#         export SOURCE_DATE_EPOCH=315532800

#         # First build, then move. Otherwise pip_pkg would create the dir $out
#         # and then put the wheel in that directory. However we want $out to
#         # point directly to the wheel file.
#         bazel-bin/tensorflow_hub/pip_package/build_pip_package . --release
#         mv *.whl "$out"
#       '';
#     };
#   };
# in
# buildPythonPackage {
#   inherit version pname;
#   format = "wheel";

#   src = bazel-wheel;

#   propagatedBuildInputs = [
#     tensorflow
#   ];

#   # # Listed here:
#   # # https://github.com/tensorflow/probability/blob/f3777158691787d3658b5e80883fe1a933d48989/testing/dependency_install_lib.sh#L83
#   # nativeCheckInputs = [
#   #   hypothesis
#   #   pytest
#   #   scipy
#   #   pandas
#   #   mpmath
#   #   matplotlib
#   #   mock
#   # ];

#   # Ideally, we run unit tests with pytest, but in checkPhase, only the Bazel-build wheel is available.
#   # But it seems not guaranteed that running the tests with pytest will even work, see
#   # https://github.com/tensorflow/probability/blob/c2a10877feb2c4c06a4dc58281e69c37a11315b9/CONTRIBUTING.md?plain=1#L69
#   # Ideally, tests would be run using Bazel. For now, lets's do a...

#   # sanity check
#   pythonImportsCheck = [ "tensorflow_hub" ];

#   meta = with lib; {
#     description = "TODO";
#     homepage = "https://www.tensorflow.org/hub/";
#     license = licenses.asl20;
#     maintainers = with maintainers; [ apraga ];
#   };
# }


# # {
# #   config,
# #   lib,
# #   pkgs,
# #   buildPythonPackage,
# #   packaging,
# #   pythonAtLeast,
# #   fetchFromGitHub,
# # }:

buildPythonPackage rec {
  pname = "tensorflow-hub";
  version = "0.16.1";

  format = "wheel";

  # src = fetchPypi {
  #   inherit version format;
  #   pname = "tensorflow_hub";
  #   hash = ""; # TODO
  #   dist = python;
  #   python = "py2.py3";
  # };
  deps = [
    tensorflow
  ];
  src = fetchurl {
    inherit pname version;
    url = "https://files.pythonhosted.org/packages/e5/50/00dba77925bf2a0a1e45d7bcf8a69a1d2534fb4bb277d9010bd148d2235e/tensorflow_hub-${version}-py2.py3-none-any.whl";
    hash = "sha256-4QwYSz0I2ur62hH/6i3UZ4FyW2vvAfrR901mNK0FMR8=";
  };

}
