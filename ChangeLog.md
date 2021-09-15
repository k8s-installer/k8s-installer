# ChangeLog

## 1.22.0-2 - 2021/xx/xx

- FIX: update nginx-ingress-controller 1.0.0-beta.3 -> 1.0.0
- 
## 1.21.4-1 - 2021/09/15

- FIX: fix metrics-server arguments
- Update nginx-ingress-controller 0.48.1 -> 1.0.0

## 1.22.0-1 - 2021/08/21

- FIX: update nginx-ingress-controller 0.48.1 -> 1.0.0-beta.3
- FIX: fix metrics-server arguments
- Update calico 3.19.1 -> 3.20.0

## 1.22.0-0 - 2021/08/15

- Update kubernetes to 1.22.0

## 1.21.4-0 - 2021/08/15

- Update kubernetes to 1.21.4
- Update rook 1.6.3 -> 1.7.1
- Update nginx-ingress-controller 0.44.0 -> 0.48.1
- Update metrics-server 0.4.2 -> 0.5.0
- Update MetalLB 0.9.5 -> 0.10.2

## 1.21.2-0 - 2021/06/27
                                    
- BREAKING CHANGE: Use containerd by default, not docker
- Update kubernetes to 1.21.2
- Update calico 3.17 -> 3.19.1
- Remove calico_felix_iptablesbackend variable, because calico default is now Auto.
- Update rook 1.5.7 -> 1.6.3 (ceph)
- Disable rook cephfs by default
- Add nerdctl to containerd

## 1.21.1-0 - 2021/05/23

- Update kubernetes to 1.21.1
- Use Docker CE by default, not OS distribution.

## 1.21.0-0 - 2021/05/04

- Update kubernetes to 1.21.0

## 1.20.5-0 - 2021/04/11

### Updates

- Update kubernetes to 1.20.5
- Update calico 3.16.7 -> 3.17.3
- Update rook 1.5.0 -> 1.5.7
                           
## 1.20.4-0 - 2021/02/21

### Updates

- Update kubernetes to 1.20.4

## 1.20.2-0 - 2021/02/15

### Updates

- Update kubernetes to 1.20.2
- Update Calico 3.16.3 -> 3.16.7  
- Update nginx-ingress-controller 0.34.1 -> 0.44.0
- Update metrics-server 0.3.7 -> 0.4.2
- Update MetalLB 0.9.3 -> 0.9.5
- Update Helm 3.4.1 -> 3.5.2  
- Get containerd from docker repo
- Improve join logic: --upload-certs, use join config yaml

## 1.20.1-0 - 2020/12/26

- Update kubernetes to 1.20.1

## 1.20.0-0 - 2020/12/11

### Updates

- Update kubernetes to 1.20.0

## 1.19.4-2 - 2020/12/11

### Bug fixes

- Fix docker install error

## 1.19.4-1 - 2020/11/17

### Updates

- Update rook 1.4.6 -> 1.5.0
- Update helm 3.2.4 -> 3.4.1

## 1.19.4-0 - 2020/11/13

### Breaking changes

- Force use systemd as cgroup driver (#16)

### Updates

- Update kubernetes 1.19.3 -> 1.19.4
- Update containerd 1.3.6 -> 1.4.1

## 1.19.3-0 - 2020/10/16

### Updates

- Update kubernetes 1.19.2 -> 1.19.3
- Update rook 1.4.2 -> 1.4.6
- Update calico 3.16.0 -> 3.16.3

## 1.19.2-1 - 2020/10/12

### Updates

- Add support for cri-o (except for offline install) (#14)
- Add support for RHEL8/CentOS8 to script installer (beta)

### Fixes

- Fix etcd image version of offline-generator

## 1.19.2-0 - 2020/09/25

- Update kubernetes 1.19.1 -> 1.19.2

## 1.18.9-0 - 2020/09/25

- Update kubernetes 1.18.8 -> 1.18.9

## 1.19.1-1, 1.18.8-2 - 2020/09/24

- Support Docker CE for RHEL8/CentOS8

# 1.19.1-0 - 2020/9/14

- Update Kubernetes 1.19.0 -> 1.19.1

## 1.19.0-1, 1.18.8-1 - 2020/09/01

- Update rook 1.4.0 -> 1.4.2
- Update calico 3.15.1 -> 3.16.0

## 1.19.0-0 - 2020/08/27

### Updates

- Support kubernetes 1.19.0

## 1.18.8-0 - 2020/08/26

Version number scheme is changed.

New version scheme is $(kubernetes_version)-$(installer_version)

## 1.0.4 - 2020/8/17

### Updates

- Update kubernetes 1.18.6 -> 1.18.8
- Do not yum versionlock kubeadm, kubelet and kubectl.

## 1.0.3 - 2020/8/14

### Updates

- Update rook 1.3.8 -> 1.4.0

## 1.0.2 - 2020/8/11

### Fixes

- Add `registry_hostnames` ansible variable for certificate (#13)

## 1.0.1 - 2020/8/5

### Fixes

- Workaround: Fix registry image version to 2.7.0 for generate htpasswd. (#12)
    - See https://github.com/docker/distribution-library-image/issues/107

## 1.0.0 - 2020/8/2

### Updates

- Update Nginx ingress controller 0.32.0 -> 0.34.1
- Update rook 1.3.7 -> 1.3.8
- Update metrics-server 0.3.6 -> 0.3.7
- Update helm 3.2.1 -> 3.2.4
- Update containerd 1.3.4 -> 1.3.6

## 0.9.7 - 2020/7/23

### Updates

- Disable IP-in-IP by default of Calico config (#11)
- Add IPIP, VXLAN, and iptables backend options for Calico. 
- Update calico 3.14.0 -> 3.15.1

## 0.9.6 - 2020/7/21

### Updates

- Update kubernetes 1.18.5 -> 1.18.6

## 0.9.5 - 2020/7/5

### Updates

- Update rook 1.3.4 -> 1.3.7 
- Exclude kubelet/kubectl/kubeadm in yum repository by default 

### Fix

- Fix ceph dashboard installation failure.

## 0.9.4 - 2020/6/30

### Updates

- Update kubernetes 1.18.4 -> 1.18.5

## 0.9.3 - 2020/6/19

### Updates

- Update kubernetes 1.18.3 -> 1.18.4
- Update rook 1.3.2 -> 1.3.4

## 0.9.2 - 2020/5/21

### Updated

- Update kubernetes 1.18.2 -> 1.18.3

### Fix

- Fix ubuntu version check miss
- Minor fixes

## 0.9.1 - 2020/5/13

### Updated

- Update calico 3.13.3 -> 3.14.0
- Update helm 3.1.2 -> 3.2.1

## 0.9.0 - 2020/5/11

### Added

- Add containerd support for RHEL/CentOS 7
- Support RHEL/CentOS 8 (#10)
- Support Ubuntu 20.04 (#9)

### Fixed

- Fix offline generator

## 0.0.7 - 2020/5/5

### Added

- Add Nginx ingress controller 0.32
- Add MetalLB 0.9.3
- Disable firewalld by default
- Alpha support for RHEL/CentOS 8 (#10)
- Add containerd role for RHEL/CentOS 8

## 0.0.6 - 2020/4/30

### Added

- Add master/configure role
- Add rook-nfs role
- Add rook-ceph role
- Add registry role

### Updated

- Support Ubuntu 20.04
- Use docker.io for Ubuntu (18.04/20.04)

### Fixed

- Offline install of ubuntu

## 0.0.5 - 2020/4/23

### Added

- Add helm v3 installation
- Add ops/reset-cluster role

### Updated

- Update calico v3.13.3
- Use cfssl to generate certificates

## 0.0.4 - 2020/4/21

### Added

- Support offline installer for Ubuntu
- Add renew-server-certs playbook
- Add longer-certs playbook

### Updated

- Generate CA certificates have longer expirations (30y).

## 0.0.3 - 2020/4/18

### Updated

- Support kubernetes 1.18.2

## 0.0.2 - 2020/4/17

### Added

- Add metrics-server 0.3.6 (#6)

### Fixed

- Disable repo_gpgcheck (#5)

## 0.0.1 - 2020/4/15

Initial release

### Added

- Support kubernetes 1.18.1
- Support script / ansible installer, offline generator
- Support RHEL 7 / CentOS 7
- Support Ubuntu 18.04 (without offline mode, and script installer)
