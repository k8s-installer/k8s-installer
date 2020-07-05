# ChangeLog

## 0.9.5 - 2020/7/5

### Updates

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
