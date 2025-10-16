#!/bin/bash

for release in $(helm list -A -q); do
  NAMESPACE=$(helm list -A | grep "^${release}\s" | awk '{print $2}')
  echo "Você quer apagar a instalação '${release}' no namespace '${NAMESPACE}'? (s/n)"
  read answer
  if [ "$answer" != "${answer#[Ss]}" ]; then
    helm uninstall ${release} -n ${NAMESPACE}
  else
    echo "skip '${release}'."
  fi
done
