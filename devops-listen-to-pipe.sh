while true; do
    pipe_value=$(cat ./bind-mounts/devops/pipe)

    case "$pipe_value" in
        "deploy-finances-app") make deploy-finances;;
    esac
done