{
  lib,
  fetchFromGitHub,
  fetchpatch,
  rPackages,
  buildPythonPackage,
  biopython,
  numpy,
  scipy,
  scikit-learn,
  pandas,
  matplotlib,
  reportlab,
  pysam,
  future,
  pillow,
  pomegranate,
  pyfaidx,
  python,
  pythonOlder,
  R,
}:

buildPythonPackage rec {
  pname = "cnvkit";
  version = "0.9.12";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "etal";
    repo = "cnvkit";
    tag = "v${version}";
    hash = "sha256-ZdE3EUNZpEXRHTRKwVhuj3BWQWczpdFbg4pVr0+AHiQ=";
  };

  patches = [
    # Numpy 2 deprecation
    (fetchpatch {
      name = "user-write-access-check";
      url = "https://github.com/etal/cnvkit/commit/5cb6aeaf40ea5572063cf9914c456c307b7ddf7a.patch";
      hash = "sha256-VwGAMGKuX2Kx9xL9GX/PB94/7LkT0dSLbWIfVO8F9NI=";
    })
    ./hmm_new_api.patch
  ];

  postPatch = ''
    # see https://github.com/etal/cnvkit/issues/589
    substituteInPlace setup.py \
      --replace 'joblib < 1.0' 'joblib'
    # see https://github.com/etal/cnvkit/issues/680
    substituteInPlace test/test_io.py \
      --replace 'test_read_vcf' 'dont_test_read_vcf'
    # np.string_` was removed in the NumPy 2.0 release. Use `np.bytes_` instead.
    substituteInPlace skgenome/intersect.py \
      --replace 'np.string_' 'np.bytes_'
  '';

  propagatedBuildInputs = [
    biopython
    numpy
    scipy
    scikit-learn
    pandas
    matplotlib
    reportlab
    pyfaidx
    pysam
    future
    pillow
    pomegranate
    rPackages.DNAcopy
  ];

  nativeCheckInputs = [ R ];

  checkPhase = ''
    pushd test/
    ${python.interpreter} test_io.py
    ${python.interpreter} test_genome.py
    ${python.interpreter} test_cnvlib.py
    ${python.interpreter} test_commands.py
    ${python.interpreter} test_r.py
    popd # test/
  '';

  pythonImportsCheck = [ "cnvlib" ];

  meta = with lib; {
    homepage = "https://cnvkit.readthedocs.io";
    description = "Python library and command-line software toolkit to infer and visualize copy number from high-throughput DNA sequencing data";
    changelog = "https://github.com/etal/cnvkit/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = [ maintainers.jbedo ];
  };
}
