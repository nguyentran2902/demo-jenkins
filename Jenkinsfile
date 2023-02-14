node {
   

    try{
//          notifyBuild('STARTED')
         stage('Clone Repo') {
            // for display purposes
            // Get some code from a GitHub repository
            git url: 'https://github.com/nguyentran2902/demo-jenkins.git',
                //credentialsId: 'springdeploy-user',
                branch: 'main'
         }
         
          stage('Initialize'){
		        def dockerHome = tool 'myDocker'
		        env.PATH = "${dockerHome}/bin:${env.PATH}"
		    }
          stage('Build docker') {
   			 def dockerImageTag = "demo-jenkins:${env.BUILD_NUMBER}"
                 dockerImage = docker.build(dockerImageTag)
          }

          stage('Deploy docker'){
                  echo "Docker Image Tag Name: ${dockerImageTag}"
                  sh "docker stop demo-jenkins || true && docker rm demo-jenkins || true"
                  sh "docker run --name demo-jenkins -d -p 8081:8081 demo-jenkins:${env.BUILD_NUMBER}"
          }
    }catch(e){
//         currentBuild.result = "FAILED"
        throw e
    }finally{
//         notifyBuild(currentBuild.result)
    }
}

def notifyBuild(String buildStatus = 'STARTED'){

// build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'
  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def now = new Date()
  // message
  def subject = "${buildStatus}, Job: ${env.JOB_NAME} FRONTEND - Deployment Sequence: [${env.BUILD_NUMBER}] "
  def summary = "${subject} - Check On: (${env.BUILD_URL}) - Time: ${now}"
  def subject_email = "Spring boot Deployment"
  def details = """<p>${buildStatus} JOB </p>
    <p>Job: ${env.JOB_NAME} - Deployment Sequence: [${env.BUILD_NUMBER}] - Time: ${now}</p>
    <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME}</a>"</p>"""



}