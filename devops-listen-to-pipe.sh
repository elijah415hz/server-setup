while true; do
    echo "listening to the pipe...."
    pipe_value=$(cat ~/server-setup/bind-mounts/devops/pipe)

    echo $pipe_value >> ~/server-setup/bind-mounts/devops/devops-log.txt

    case "$pipe_value" in
        "deploy-finances-app") cd ~/server-setup && make deploy-finances 2>> ~/server-setup/bind-mounts/devops/devops-log.txt && echo "deploy complete" >> ~/server-setup/bind-mounts/devops/devops-log.txt;;
    esac
    echo "out of the case...."
done
