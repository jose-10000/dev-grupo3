#!/bin/bash
# Delete the deployment

# Delete application
kubectl delete -f k8s/

# Delete deployment
kubectl delete -f .

# Delete MongoDB Atlas Operator Project
kubectl delete -f https://raw.githubusercontent.com/mongodb/mongodb-atlas-kubernetes/main/deploy/all-in-one.yaml

# Delete the MongoDB Atlas Secret
kubectl delete secret atlaspassword
