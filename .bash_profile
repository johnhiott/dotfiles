alias gs='git status -sb'
alias gd='git diff'
alias startvm='VBoxManage startvm "Ubuntu 14.04 LTS Servera" --type headless'
alias stopvm='VBoxManage controlvm "Ubuntu 14.04 LTS Servera" poweroff'
alias resetvm='VBoxManage controlvm "Ubuntu 14.04 LTS Servera" reset'


function rsyncrepos {
        repolist=('api' 'custom' 'delayedproc' 'migration' 'mobile' 'mobilepayweb' 'notifications' 'opmgmt' 'parkmonitor' 'paymentgateway' 'ppconfig' 'rate' 'shared' 'validation-old' 'violations')
        if (( $# != 0 )); then
                repolist=("$@")
        fi
        rLen=${#repolist[@]}
        echo $'\n\E[35m'
        echo "Starting rsync for repos: ${repolist[@]}"
        echo $'\n'
        for (( i=0; i<${rLen}; i++ )); do
                echo $'\E[31m'
                remotepath=${repolist[$i]}
                if [[
                        $remotepath == "notifications" ||
                        $remotepath == "opmgmt"
                ]]; then
                        remotepath="server/$remotepath"
                fi
                rsync -ave ssh --delete "/Users/johnhiott/Development/passportrepos/${repolist[$i]}/" ppimage:"~/workspace/$remotepath/"
                message="Started rsync for repo: '"
                message+=$'\E[36m'
                message+=${repolist[$i]}
                message+=$'\E[31m'
                message+="'"
                echo $message
                echo $'\E[37m'
        done
        echo $'\n\E[33m'
        echo "Rsync has finished for all repos"
        echo $'\E[37m'
}

function clonerepos {
        repolist=('custom' 'delayedproc' 'migration' 'mobile' 'mobilepayweb' 'notifications' 'opmgmt' 'parkmonitor' 'paymentgateway' 'ppconfig' 'rate' 'shared' 'validation-old' 'violations')
        if (( $# != 0 )); then
                repolist=("$@")
        fi
        rLen=${#repolist[@]}
        echo $'\n\E[35m'
        echo "Cloning all repos: ${repolist[@]}"
        echo $'\n'
        for (( i=0; i<${rLen}; i++ )); do
                echo $'\E[31cd ..
                git clone "git@gitlab.myeasyp.com:passport-parking/${repolist[$i]}.git"
        done
   }



function start_tunnels {
	kill_tunnels
	echo $'\E[36m'
	echo "Starting Tunnels"
	ssh -f -L 8080:localhost:80 ppinfo -N
	ssh -f -L 8181:localhost:80 easypparking -N
echo $'\E[33m'
	echo "All Tunnels Have Been Started!"
}


function kill_tunnels {
	ports=('8080' '8181')
	echo $'\E[31m'
	echo "Killing Tunnels: ${ports[@]}"
	echo $'\E[37m'
	for port in "${ports[@]}"; do
		pid=$(pgrep -f $port":localhost")
		if [[ "$pid" -gt 0 ]]; then
			kill $pid
			message=$'\E[35m'
			message+="Killed Tunnel With Port: '"
			message+=$'\E[36m'
			message+=$port
			message+=$'\E[35m'
			message+="' and PID: '"
			message+=$'\E[36m'
			message+=$pid
			message+=$'\E[35m'
			message+="'"
			message+=$'\E[37m'
			echo $message
		fi
	done
	echo $'\E[33m'
	echo "All Tunnels Have Been Killed!"
}
