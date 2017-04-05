# Install Puppet

## Agent

### CentOS / RHEL

A quick one liner to install and configure a puppet agent. This assumes a FDQN host name and clean RHEL / CentOS build, make sure you pass the script the hostname of your Puppet Server at the end;

```bash
curl -fsS https://raw.githubusercontent.com/01100010011001010110010101110000/puppet-install/master/agent.sh | bash -s <MASTER_FQDN> [ENVIRONMENT]
```
