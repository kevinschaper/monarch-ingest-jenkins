pipeline {
    environment {
        HOME = "${env.WORKSPACE}"
//         JENKINS_USER_NAME = "${sh(script:'id -un', returnStdout: true).trim()}"
//         JENKINS_USER_ID = "${sh(script:'id -u', returnStdout: true).trim()}"
//         JENKINS_GROUP_ID = "${sh(script:'id -g', returnStdout: true).trim()}"
    }
    agent {
        dockerfile {
            filename 'Dockerfile'
//             additionalBuildArgs '''\
//               --build-arg GID=$JENKINS_GROUP_ID \
//               --build-arg UID=$JENKINS_USER_ID \
//               --build-arg UNAME=$JENKINS_USER_NAME \
//             '''
        }
    }
    stages {
        stage('Initialize') {
            steps {
                git branch: 'main', url: 'https://github.com/monarch-initiative/monarch-ingest.git'
                sh '''
                    pwd
                    ls -l
                    mkdir -p data/zfin
                    wget https://zfin.org/downloads/gene_publication.txt
                    mv gene_publication.txt data/zfin
                    venv/bin/koza transform --source monarch_ingest/zfin/gene_to_publication.yaml
                    gsutil cp output/zfin_gene_to_publication* gs://monarch-ingest/output/
                    '''
            }
        }
    }
}

