#!/bin/bash
# Checks the health of all cloud-platform-app pods in a given namespace.
# Exits non-zero if any pod is not Running/Ready, so this can be wired
# into a CI job or cron alert later.

NAMESPACE=${1:-default}
APP_LABEL="app=cloud-platform-app"

echo "Checking pod health for '$APP_LABEL' in namespace '$NAMESPACE'..."

UNHEALTHY_PODS=$(kubectl get pods -n "$NAMESPACE" -l "$APP_LABEL" \
  --field-selector=status.phase!=Running -o name)

if [ -n "$UNHEALTHY_PODS" ]; then
  echo "WARNING: The following pods are not Running:"
  echo "$UNHEALTHY_PODS"
  exit 1
fi

NOT_READY=$(kubectl get pods -n "$NAMESPACE" -l "$APP_LABEL" \
  -o jsonpath='{range .items[*]}{.metadata.name}{" "}{.status.containerStatuses[0].ready}{"\n"}{end}' \
  | grep "false")

if [ -n "$NOT_READY" ]; then
  echo "WARNING: The following pods are Running but not Ready:"
  echo "$NOT_READY"
  exit 1
fi

echo "All pods healthy."
exit 0
