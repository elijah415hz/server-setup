while true; do
    pipe_value=$(cat ./bind-mounts/devops/pipe)

    echo $pipe_value >> ./devops-log.txt

    case "$pipe_value" in
        "deploy-finances-app") make deploy-finances;;
    esac
done