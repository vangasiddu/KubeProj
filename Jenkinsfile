def CONTAINER_NAME="ositest"
def CONTAINER_TAG="latest"
def DOCKER_HUB_USER="rajugade"
def HTTP_PORT="8099"

node {

   /* stage('Initialize'){
        def dockerHome = tool 'MyDocker'
        def mavenHome  = tool 'MyMaven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }*/

    stage('Checkout') {
        checkout scm
    }

   /* stage('Build'){
       bat "mvn clean install"
    }
    stage('Sonar'){
        try {
            "mvn sonar:sonar"
        } catch(error){
            echo "The sonar server could not be reached ${error}"
        }
     }*/

    stage("Image Prune"){
        //imagePrune(CONTAINER_NAME)
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }

    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'dockercreds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            pushToImage(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
        }
       stage('Deploy'){
            deployKube()
        }
    }

    /*stage('Run App'){
        runApp(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, HTTP_PORT)
    }*/
    

}

def imagePrune(containerName){
    try {
       sh "docker image prune -f"
       //bat "docker stop $containerName"
    } catch(error){}
}

def imageBuild(containerName, tag){
    
    sh "docker build -t $containerName:$tag  -t $containerName --pull --no-cache ."
    echo "Image build complete"
}

def pushToImage(containerName, tag, dockerUser, dockerPassword){
    sh "docker login -u $dockerUser -e raju.g1233@gmail.com -p $dockerPassword"
    sh "docker tag $containerName:$tag $dockerUser/$containerName:$tag"
    sh "docker push $dockerUser/$containerName:$tag"
    echo "Image push complete"
}

def runApp(containerName, tag, dockerHubUser, httpPort){
    sh "docker pull $dockerHubUser/$containerName"
    sh "docker run -d --rm -p $httpPort:$httpPort --name $containerName $dockerHubUser/$containerName:$tag"
    echo "Application started on port: ${httpPort} (http)"
}


def deployKube(){
      //  sh "kubectl delete deployment appname"
      //  sh "kubectl delete service appname"
        sh "kubectl run appname --image=docker.io/rajugade/ositest:latest --port=8080"
        sh "kubectl get deployments"
        sh "kubectl expose deployment appname --type=NodePort"
  
}
