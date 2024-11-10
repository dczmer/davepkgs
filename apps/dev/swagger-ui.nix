{
  docker,
  dockerTools,
  writeShellApplication,
  port ? "8080",
  swaggerFile ? "/swagger/openapi.yaml",
  swaggerVol ? "/tmp/swagger",
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
    docker load -i ${swagger-ui-image}
    docker run -p ${port}:8080 \
    -e SWAGGER_JSON=${swaggerFile} \
    -v ${swaggerVol}:/swagger swaggerapi/swagger-ui
  '';
}
