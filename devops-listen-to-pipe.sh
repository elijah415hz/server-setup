while true; do
    pipe_value=$(cat ~/server-setup/bind-mounts/devops/pipe)

    echo $pipe_value >> ~/server-setup/bind-mounts/devops/devops-log.txt

    case "$pipe_value" in
        "deploy-finances-app") make deploy-finances;;
    esac
done