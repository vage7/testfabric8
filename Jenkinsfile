#!/usr/bin/groovy
def envStage = "${env.JOB_NAME}-staging"

node ('kubernetes'){

  git 'https://github.com/vage7/testfabric8.git'

  stage 'canary release'
    if (!fileExists ('Dockerfile')) {
      writeFile file: 'Dockerfile', text: 'FROM anapsix/alpine-java'
    }

    def newVersion = performCanaryRelease {}

    def rc = getKubernetesJson {
      label = 'test'
      version = newVersion
      imageName = clusterImageName
    }

  stage 'Rolling upgrade Staging'
    kubernetesApply(file: rc, environment: envStage)

}
