#!/bin/bash

# this is no systemd service or does not behave like one.
service auditd stop
chkconfig auditd off
systemctl mask systemd-journald-audit.socket
