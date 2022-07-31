#!/bin/bash

echo '
   [
     ":START_ID",
     ":END_ID",
     "channel_id",
     "chan_point",
     "last_update:int",
     "capacity:long",
     "node1_policy_time_lock_delta:int",
     "node1_policy_min_htlc:int",
     "node1_policy_fee_base_msat:int",
     "node1_policy_fee_rate_milli_msat:int",
     "node1_policy_disabled:boolean",
     "node1_policy_max_htlc_msat:int",
     "node1_policy_last_update:int",
     "node2_policy_time_lock_delta:int",
     "node2_policy_min_htlc:int",
     "node2_policy_fee_base_msat:int",
     "node2_policy_fee_rate_milli_msat:int",
     "node2_policy_disabled:boolean",
     "node2_policy_max_htlc_msat:int",
     "node2_policy_last_update:int",
     ":TYPE"
   ]
' | jq -r '@csv'

jq -r '.edges
  | .[]
  | select(.node1_policy and .node2_policy)
  | [
      .node1_pub,
      .node2_pub,
      .channel_id,
      .chan_point,
      .last_update,
      .capacity,
      .node1_policy.time_lock_delta,
      .node1_policy.min_htlc,
      .node1_policy.fee_base_msat,
      .node1_policy.fee_rate_milli_msat,
      .node1_policy.disabled,
      .node1_policy.max_htlc_msat,
      .node1_policy.last_update,
      .node2_policy.time_lock_delta,
      .node2_policy.min_htlc,
      .node2_policy.fee_base_msat,
      .node2_policy.fee_rate_milli_msat,
      .node2_policy.disabled,
      .node2_policy.max_htlc_msat,
      .node2_policy.last_update,
      "CHANNEL"
    ]
  | @csv
'
