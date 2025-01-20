pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to use')
        string(name: 'TEST_CASE_IDS', defaultValue: '', description: 'Comma-separated list of test case IDs')
        string(name: 'TEST_DIRECTORY', defaultValue: '', description: 'Directory to execute all tests from')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${params.BRANCH_NAME}", url: 'https://github.com/your-username/robot-framework-sap-tests.git'
            }
        }

        stage('Execute Tests') {
            steps {
                script {
                    if (params.TEST_CASE_IDS) {
                        def testCases = params.TEST_CASE_IDS.split(',')
                        testCases.each { testCase ->
                            sh "robot --outputdir results --test ${testCase} test-cases/"
                        }
                    } else if (params.TEST_DIRECTORY) {
                        sh "robot --outputdir results test-cases/${params.TEST_DIRECTORY}"
                    } else {
                        sh "robot --outputdir results test-cases/"
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**/*'
            junit 'results/output.xml'
        }
    }
}