# Docker Utils

This project will hold a set of utils used for supporting Docker builds and continuous deployment.

## Tools

### envvars_consul.sh

This script helps to set up variables from a [Consul KV server](https://www.consul.io/). It needs 3 pieces of information present as existing environment variables to do so.

* CONSUL_URL - The Consul server.
* APP - The name of the application being deployed.
* APP_ENV - The environment the docker application is being run at.

These variables are optional and driven by the CONSUL_URL. If there is no Consul server present, the script quits gracefully and assumes the container to take care of variables.

#### Running

Since environment variables are per shell, this script requires the bash shell to run. Either set the entry point to be bash instead of the default shell sh or link sh to bash at container build time.


    > source envvars_consul.sh && <Your commands here>
 
