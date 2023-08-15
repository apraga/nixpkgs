{ python3Packages, fetchPypi, lib }:

python3Packages.buildPythonApplication rec {
  version = "1.15";
  pname = "multiqc";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-zlNZoSImz0zjcsb9rRQs/irnUB/6l6x6q1RM7U216jw=";
  };
  doCheck = false;
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

  meta = with lib; {
    description = "create a single report with interactive plots for multiple bioinformatics analyses across many samples.";
    homepage = "https://multiqc.info/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ apraga ];
  };
}
