{
  docker,
  dockerTools,
  writeShellApplication,
}:
let
  prism-image = dockerTools.pullImage {
    imageName = "stoplight/prism";
    imageDigest = "sha256:08dc16243047a3263beca814b544a5be81e9ec25ca5757cdc4170c84f7431355";
    sha256 = "sha256-kw4L+b6F5GRJiUxNHA02o/FJ5mBqq9MTByz7FOZJpxY=";
  };
in
writeShellApplication rec {
  name = "prism-mock";
  runtimeInputs = [
    prism-image
    docker
  ];
  text = ''
    if [ "$#" -ne 3 ]; then
      echo "${name} <PORT> <DIR>:<VOL> <VOL>/<SWAGGER_FILE>"
      echo "EXAMPLE:"
      echo "    ${name} 4010 .:/prism /prism/openapi.yaml"
      exit 1
    fi
    PORT=$1
    VOL=$2
    FILE=$3

    docker load -i ${prism-image}
    docker run -i -p "$PORT":4010 \
      -v "$VOL" \
      stoplight/prism:latest \
      mock \
      -h 0.0.0.0 \
      "$FILE"
  '';
}
