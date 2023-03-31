group "default" {
    targets = ["keycloak", "keycloak-alpine"]
}

variable "VERSION" {
  default = "999.0.0-SNAPSHOT"
}

variable "TAG" {
  default = "keycloak:${VERSION}"
}
target "docker-metadata-action" {}

target "keycloak" {
    inherits = ["docker-metadata-action"]
    context = "."
    dockerfile = "Dockerfile"
    args = {
        DIST = "amazonlinux"
        KEYCLOAK_VERSION = "${VERSION}"
    }
    tags = ["${TAG}"]
}

target "keycloak-alpine" {
    inherits = ["keycloak"]
    args = {
        DIST = "alpine"
        KEYCLOAK_VERSION = "${VERSION}"
    }
    tags = ["${TAG}-alpine"]
}
