# ChangeLog

## x.x.x

### Updated

- Support Ubuntu 20.04 (except for offline install)
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
