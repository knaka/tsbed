pushd . > /dev/null 2>&1

while true
do
  if test "$PWD" = /
  then
    exit 1
  fi
  if test -r docker-compose.y*ml
  then
    break
  fi
  cd ..
done

service=db
port=5432

config="$(docker compose config | yq -c)"
# override をしている場合などでは、`docker compose config` では正しく取れないことがある。
# If you are doing override, `docker compose config` may not get it correctly.
# port=$(docker inspect -f "{{(index (index .NetworkSettings.Ports \"${port}/tcp\") 0).HostPort}}" "$(docker compose ps --quiet ${service})")
port=$(jq -r ".services.${service}.ports[] | select(.target == $port) | .published" <<< "$config")
user=$(jq -r ".services.${service}.environment.POSTGRES_USER" <<< "$config")
# shellcheck disable=SC2034
db="$user"
# shellcheck disable=SC2034
password=$(jq -r ".services.${service}.environment.POSTGRES_PASSWORD" <<< "$config")

popd > /dev/null 2>&1 || exit
