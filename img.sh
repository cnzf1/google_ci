#!/usr/bin/env bash

pull=1
push=1

list=(cnzf/k8s.io:sig-storage.snapshot-controller.v6.2.2
  cnzf/k8s.io:sig-storage.csi-snapshotter.v6.2.1
  cnzf/k8s.io:sig-storage.csi-snapshotter.v6.2.2
  cnzf/k8s.io:sig-storage.csi-resizer.v1.7.0
  cnzf/k8s.io:sig-storage.csi-resizer.v1.8.0
  cnzf/k8s.io:sig-storage.csi-attacher.v4.1.0
  cnzf/k8s.io:sig-storage.csi-attacher.v4.3.0
  cnzf/k8s.io:sig-storage.csi-provisioner.v3.4.0
  cnzf/k8s.io:sig-storage.csi-provisioner.v3.5.0
  cnzf/k8s.io:sig-storage.csi-node-driver-registrar.v2.7.0
  cnzf/k8s.io:sig-storage.csi-node-driver-registrar.v2.8.0
  cnzf/k8s.io:sig-storage.livenessprobe.v2.3.0
  cnzf/k8s.io:sig-storage.livenessprobe.v2.10.0
)

old=cnzf/k8s.io
#new=registry.k8s.io
new=10.90.4.90

for i in ${list[*]}; do
  [[ $pull -eq 1 ]] && docker pull $i
  j=$(echo $i | sed "s%$old:%%")
  v=$(echo $j | grep -oP "\.v\d.*" | cut -c 2-)
  let vn=${#v}+1
  pre=$(echo $j | sed "s/.\{$vn\}$//")
  #echo $pre
  d=$new/${pre/\./\/}:$v
  #echo $d
  docker tag $i $d
  [[ $push -eq 1 ]] && docker push $d
done
