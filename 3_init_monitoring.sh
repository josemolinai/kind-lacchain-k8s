#!/bin/sh
helmfile -n monitoring --debug --log-level debug -f ./helm/monitoring.yaml apply
