{ lib
, python3Packages
, fetchPypi
, fetchFromGitHub
}:

let  test-data = fetchFromGitHub {
    owner = "MultiQC";
    repo = "test-data";
    rev = "d3e5dc356ef25011287f1ba65605d2ef82bb84e5";
    hash = "";
  }; in

python3Packages.buildPythonApplication rec {
  version = "1.21";
  pname = "multiqc";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Y7yH4lHb94jcyKReWEguoJsm0FlXv1DHfGhNXwlypJU=";
  };
  # doCheck = false;
  # Specify dependencies
  propagatedBuildInputs = with python3Packages; [
    click
    coloredlogs
    future
    jinja2
    lzstring
    markdown
    matplotlib
    networkx
    numpy
    pyyaml
    requests
    rich
    rich-click
    simplejson
    spectra
  ];

# checkPhase = """
    # MULTIQC_TEST_ROOT=${test-data} bash test/run_unit_tests.sh
# """;
  nativeCheckInputs = [
    python3Packages.pytestCheckHook
  ];

 # requires additional data
  pytestFlagsArray = [
    "${test-data}"
  ];
  meta = with lib; {
    description = "create a single report with interactive plots for multiple bioinformatics analyses across many samples.";
    homepage = "https://multiqc.info/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ apraga ];
  };
}
