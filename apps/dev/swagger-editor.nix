{
  docker,
  dockerTools,
  writeShellApplication,
  port ? "8080",
  swaggerFile ? "/swagger/openapi.yaml",
  swaggerVol ? "/tmp/swagger",
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
    docker load -i ${swagger-editor-image}
    docker run -p ${port}:8080 \
    -e SWAGGER_FILE=${swaggerFile} \
    -v ${swaggerVol}:/swagger swaggerapi/swagger-editor
  '';
}
