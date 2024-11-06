pipeline {
    agent { label "one" }
    
    stages {
        
        stage("code") {
            steps {
                echo "for cloning the code"
                git url: "https://github.com/LondheShubham153/django-notes-app", branch: "main"
            }
        }
        
        stage("build") {
            steps {
                echo "for building the code"
            }
        }
        
        stage("test") {
            steps {
                echo "for testing the code"
            }
        }
        
        stage("deploy") {
            steps {
                echo "for deploying the code"
            }
        }
    }
}
