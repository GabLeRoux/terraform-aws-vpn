#!/usr/bin/env bash

set -x
set -e

function get_instance_id_by_name() {
    instance_name=$1
    aws ec2 describe-instances \
    | jq '[.Reservations | .[] | .Instances | .[] | select(.State.Name!="terminated") | select((.Tags[]|select(.Key=="Name")|.Value) =="'"$instance_name"'") | {Name: (.Tags[]|select(.Key=="Name")|.Value), InstanceId: .InstanceId}]' \
    | jq -r ".[] | .InstanceId"
}
