sudo sysctl -w kernel.keys.maxkeys=5000
sudo sysctl -w fs.inotify.max_user_watches=2099999999
sudo sysctl -w fs.inotify.max_user_instances=2099999999
sudo sysctl -w fs.inotify.max_queued_events=2099999999
#sudo modprobe openvswitch

#ovn-kubernetes/contrib/kind.sh --install-cni-plugins --disable-snat-multiple-gws --multi-network-enable --enable-interconnect
#export KUBECONFIG=$HOME/ovn.conf
#kubectl label node ovn-worker node-role.kubernetes.io/worker-spk="" --overwrite=true
#kubectl cordon ovn-control-plane
