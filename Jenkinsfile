pipeline {
    agent none
    environment {
        HOME = "${env.WORKSPACE}"
//         JENKINS_USER_NAME = "${sh(script:'id -un', returnStdout: true).trim()}"
//         JENKINS_USER_ID = "${sh(script:'id -u', returnStdout: true).trim()}"
//         JENKINS_GROUP_ID = "${sh(script:'id -g', returnStdout: true).trim()}"
    }
    stages {
        stage('Initialize') {
            agent {
                dockerfile {
                    label 'large-worker'
                    filename 'Dockerfile'
        //             additionalBuildArgs '''\
        //               --build-arg GID=$JENKINS_GROUP_ID \
        //               --build-arg UID=$JENKINS_USER_ID \
        //               --build-arg UNAME=$JENKINS_USER_NAME \
        //             '''
                }
            }
            steps {
                sh 'cd /tmp/workspace/ingest-test'
                git branch: 'main', url: 'https://github.com/monarch-initiative/monarch-ingest.git'
                sh '''
                    pwd
                    ls -l
                    /monarch-ingest/venv/bin/dagster job execute -f monarch_ingest/ingest_pipeline.py
//                    mkdir -p data/zfin
//                    wget -q https://zfin.org/downloads/gene_publication.txt
//                    mv gene_publication.txt data/zfin
//                    ls -la /monarch-ingest/venv/bin/koza
//                    /monarch-ingest/venv/bin/koza transform --source monarch_ingest/zfin/gene_to_publication.yaml --row-limit 1000
                    '''
            }
        }
        stage('upload') {
            agent { label 'worker'}
            steps {
                sh 'cd /tmp/workspace/ingest-test'
                sh 'pwd'
                sh 'ls -l'
                sh 'gsutil cp -r output/* gs://monarch-ingest/experimental-output/'
            }
        }
    }
}

