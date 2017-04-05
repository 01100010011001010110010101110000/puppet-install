#!/bin/bash

echo "======================================================================================"
echo ""
echo "Puppet Agent Installation"
echo ""
echo "This script will install a Puppet Agent on a RHEL / CentOS server."
echo ""
echo "======================================================================================"
echo ""
MINIMUM_ARGS=2
E_BADARGS=65

echo "=> Getting OS version ..."
OS_MAJ_VERSION=$(rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3)
echo "=> Done!"

if [ $# -le $EXPECTED_ARGS ]
then
  echo "Usage: $0 <MASTER_FQDN> [ENVIRONMENT]"
  exit $E_BADARGS
fi

echo "=> Getting hostname ..."
MASTER_HOSTNAME=$1
ENVIRONMENT=$2
MY_HOSTNAME=$HOSTNAME
echo "=> Found $MASTER_HOSTNAME"
echo "=> Done!"
echo "=> Adding Puppetlabs Yum repo ..."
yum install -y http://yum.puppetlabs.com/puppetlabs-release-el-"$OS_MAJ_VERSION".noarch.rpm > /dev/null 2>&1
echo "=> Done!"
echo "=> Installing Puppet Agent ..."
yum -y install puppet > /dev/null 2>&1
echo "=> Done!"
echo "=> Configuring Puppet Agent ..."
echo "[main]
    logdir = /var/log/puppet
    rundir = /var/run/puppet
    ssldir = $vardir/ssl
    server = $MASTER_HOSTNAME
    environment = $ENVIRONMENT

[agent]
    classfile = $vardir/classes.txt
    localconfig = $vardir/localconfig" > /etc/puppet/puppet.conf
echo "=> Done!"
echo "=> Running puppet agent"
puppet agent -t
echo "=> Ensuring Puppet Agent is running ..."
puppet resource service puppet ensure=running enable=true > /dev/null 2>&1
echo "=> Done!"
echo ""
