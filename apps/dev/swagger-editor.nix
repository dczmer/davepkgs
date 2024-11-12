# NOTE: application must DISABLE CORS protection, or else must run from same domain/origin.
#       could possibly do this with a localhost nginx as a reverse proxy to bridge one domain.
#       or just hack in `Access-Control-Allow-Origin: *`.
{
  docker,
  dockerTools,
  writeShellApplication,
}:
let
  swagger-editor-image = dockerTools.pullImage {
    imageName = "swaggerapi/swagger-editor";
    imageDigest = "sha256:edba56990c225944dce0254d76d6aac4586bfcdab96328e300375176a5088dda";
    sha256 = "sha256-v13qRT4zUPXpg2o9naNlsD+0gzpnHhXUFT0LaZ2PmjU=";
  };
in
writeShellApplication {
  name = "swagger-editor";
  runtimeInputs = [
    swagger-editor-image
    docker
  ];
  text = ''
    if [ "$#" -ne 3 ]; then
      echo "$0 <PORT> <VOL>/<SWAGGER_FILE> <DIR>:<VOL>"
      echo "EXAMPLE:"
      echo "    $0 8080 /swagger/openapi.yaml .:/swagger"
      exit 1
    fi
    PORT=$1
    FILE=$2
    VOL=$3
    docker load -i ${swagger-editor-image}
    docker run -p "$PORT":8080 \
    -e SWAGGER_FILE="$FILE" \
    -v "$VOL" swaggerapi/swagger-editor
  '';
}
