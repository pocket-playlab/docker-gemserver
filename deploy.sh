#!/bin/bash

set -e

pull() {
  local server=$1
  echo "Pulling repository on $server"
  ssh core@$server "docker pull quay.io/ssro/gemserver:quay"
}

# Need to pull on all servers
for i in $(env|grep CORE|cut -d "=" -f 2)
do
  pull "$i" &
done
wait

# Then connect to one controller is enough
ssh core@$CORE1  "fleetctl stop gemserver-quay \
                                  presence-gemserver-quay \
                                  && fleetctl start gemserver-quay \
                                  presence-gemserver-quay"