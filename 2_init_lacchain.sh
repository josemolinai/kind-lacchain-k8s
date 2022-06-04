#!/bin/sh
helmfile -n lacchain-network --debug --log-level debug -f ./helm/lacchain.yaml apply
