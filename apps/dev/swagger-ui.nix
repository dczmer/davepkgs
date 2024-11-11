{
  docker,
  dockerTools,
  writeShellApplication,
}:
let
  swagger-ui-image = dockerTools.pullImage {
    imageName = "swaggerapi/swagger-ui";
    imageDigest = "sha256:79cf8c3d82ea8a3c0984efce165d554ad50ae55b136c75ab8070cf5c2e6c636a";
    sha256 = "sha256-H0cngRn61iMrJjoXCzGw/M04Ned1tw7XL6zWCT1LQPo=";
  };
in
writeShellApplication {
  name = "swagger-ui";
  runtimeInputs = [
    swagger-ui-image
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
    docker load -i ${swagger-ui-image}
    docker run -p "$PORT":8080 \
    --add-host=host.docker.internal:host-gateway \
    --network=bridge \
    -e SWAGGER_JSON="$FILE" \
    -v "$VOL" swaggerapi/swagger-ui
  '';
}
