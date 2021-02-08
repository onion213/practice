docker-compose exec jupyter jupyter notebook list | grep http | xargs -n 1 open
