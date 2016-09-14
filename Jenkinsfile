node {
	checkout scm

	sh 'git rev-parse --abbrev-ref HEAD > GIT_BRANCH'
	git_branch = readFile('GIT_BRANCH').trim()

	sh 'git rev-parse HEAD > GIT_COMMIT'
    git_commit = readFile('GIT_COMMIT').trim()
    short_git_commit = git_commit

    sh 'git describe > GIT_DESCRIBE'
    git_tag = readFile('GIT_DESCRIBE').trim()
    sh "git tag -l --format '%(subject)' -n ${git_tag} > GIT_TAG_MESSAGE"
    def deploy = readFile('GIT_TAG_MESSAGE').trim()


    def HOST_LIST = ["b4tbfront1", "b4tbback1"]
    def HOST_IP_LIST = ["10.6.0.73", "10.6.0.74"]
    def USERNAME = "jenkins"
    def FOLDER_LIST = ["/opt/b4tb/web", "/opt/b4tb/db", "/opt/b4tb/integration", "/opt/b4tb/backoffice", "/opt/b4tb/static", "/opt/b4tb/tmp"]
    def SERVICE_LIST = ["fantasybet-web", "fantasybet-db", "fantasybet-integration", "fantasybet-backoffice"]
    //def FOLDER = "tmp"

    def workspace = pwd()
    
    def mvnHome = tool 'maven31'

    stage 'Build'
    //sh "${mvnHome}/bin/mvn clean package -P${deploy}"
    sh "${mvnHome}/bin/mvn clean package -Pdev"

    echo "Packaged parent pom successfully for release ${deploy}"

    withCredentials([[$class: 'FileBinding', credentialsId: 'b4tb-creds', variable: 'SSH_KEY']]) {


    	stage 'Deploy fantasybet-db'
    	echo "Uploading to ${HOST_LIST[1]} fantasybet-db.jar for ${deploy} to ${USERNAME}@${HOST_IP_LIST[1]}:/opt/b4tb/tmp/"	
	    sh "rsync -rave \"ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY}\" ${workspace}/fantasybet-db/target/fantasybet-db.jar ${USERNAME}@${HOST_IP_LIST[1]}:/opt/b4tb/tmp/fantasybet-db.jar"
	    sh "ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY} ${USERNAME}@${HOST_IP_LIST[1]} \"sudo rm -f /opt/b4tb/db/fantasybet-db.jar && \
	    	sudo mv /opt/b4tb/tmp/fantasybet-db.jar /opt/b4tb/db/fantasybet-db.jar && \
	    	sudo chown b4tb:jenkins /opt/b4tb/db/fantasybet-db.jar && \
	    	sudo /usr/bin/java -Dsun.misc.URLClassPath.disableJarChecking=true -Dspring.config.location=/opt/b4tb/db/application.properties -Xmx512m -jar /opt/b4tb/db/fantasybet-db.jar\""
	    

		stage 'Deploy fantasybet-web'
		echo "Uploading to ${HOST_LIST[0]} fantasybet-web.jar for ${deploy} to ${USERNAME}@${HOST_IP_LIST[0]}:/opt/b4tb/tmp/"	
	    sh "rsync -rave \"ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY}\" ${workspace}/fantasybet-web/target/fantasybet-web.jar ${USERNAME}@${HOST_IP_LIST[0]}:/opt/b4tb/tmp/fantasybet-web.jar"
	    sh "ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY} ${USERNAME}@${HOST_IP_LIST[0]} \"sudo service fantasybet-web stop && \
	    	sudo rm -f /opt/b4tb/web/fantasybet-web.jar && \
	    	sudo mv /opt/b4tb/tmp/fantasybet-web.jar /opt/b4tb/web/fantasybet-web.jar && \
	    	sudo chown b4tb:jenkins /opt/b4tb/web/fantasybet-web.jar && \
	    	sudo service fantasybet-web start\""

	    stage 'Deploy fantasybet-integration'
		echo "Uploading to ${HOST_LIST[1]} fantasybet-integration.jar for ${deploy} to ${USERNAME}@${HOST_IP_LIST[1]}:/opt/b4tb/tmp/"	
	    sh "rsync -rave \"ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY}\" ${workspace}/fantasybet-integration/target/fantasybet-integration.jar ${USERNAME}@${HOST_IP_LIST[1]}:/opt/b4tb/tmp/fantasybet-integration.jar"
	    sh "ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY} ${USERNAME}@${HOST_IP_LIST[1]} \"sudo service fantasybet-integration stop && \
	    	sudo rm -f /opt/b4tb/integration/fantasybet-integration.jar && \
	    	sudo mv /opt/b4tb/tmp/fantasybet-integration.jar /opt/b4tb/integration/fantasybet-integration.jar && \
	    	sudo chown b4tb:jenkins /opt/b4tb/integration/fantasybet-integration.jar && \
	    	sudo service fantasybet-integration start\""
	    
	    stage 'Deploy fantasybet-backoffice'
		echo "Uploading to ${HOST_LIST[0]} fantasybet-backoffice.jar for ${deploy} to ${USERNAME}@${HOST_IP_LIST[0]}:/opt/b4tb/tmp/"	
	    sh "rsync -rave \"ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY}\" ${workspace}/fantasybet-backoffice/target/fantasybet-backoffice.jar ${USERNAME}@${HOST_IP_LIST[0]}:/opt/b4tb/tmp/fantasybet-backoffice.jar"
	    sh "ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY} ${USERNAME}@${HOST_IP_LIST[0]} \"sudo service fantasybet-backoffice stop && \
	    	sudo rm -f /opt/b4tb/backoffice/fantasybet-backoffice.jar && \
	    	sudo mv /opt/b4tb/tmp/fantasybet-backoffice.jar /opt/b4tb/backoffice/fantasybet-backoffice.jar && \
	    	sudo chown b4tb:jenkins /opt/b4tb/backoffice/fantasybet-backoffice.jar && \
	    	sudo service fantasybet-backoffice start\""
	    
	    /*
	    stage 'Deploy STATIC'
	    sh "rsync -rcavzhe \"ssh -oStrictHostKeyChecking=no -i ${env.SSH_KEY}\" --delete --include=\"dist/\" --include=\"dist/**\" --include=\"resources/\" --include=\"resources/**\" --exclude \"*\" ${workspace}/aon-web/src/main/resources-${deploy}/static-${deploy}/assets/ ${AWS_USERNAME}@${AWS_HOST_IP}:/opt/aon/${AWS_FOLDER}/static/assets/"

	    */
	}
}
