
MATCH (n)-[c]-()
WITH n,
     c.capacity AS capacity,
    CASE startNode(c)
        WHEN n THEN [c.node1_policy_fee_rate_milli_msat, c.node1_policy_fee_base_msat, c.node2_policy_fee_rate_milli_msat, c.node2_policy_fee_base_msat]
        ELSE [c.node2_policy_fee_rate_milli_msat, c.node1_policy_fee_rate_milli_msat]
    END AS fees
WITH n,
     capacity,
    fees[0] as fee_rate_milli_msat,
    fees[1] as fee_base_msat,
    fees[2] as partner_fee_rate_milli_msat,
    fees[3] as partner_fee_base_msat
WITH n,
    count(fee_rate_milli_msat) AS degree,
    sum(capacity) AS capacity,
    percentileDisc(capacity, 0.25) AS capacity_p25,
    percentileDisc(capacity, 0.5) AS capacity_p50,
    percentileDisc(capacity, 0.75) AS capacity_p75,

    percentileDisc(fee_rate_milli_msat, 0.25) AS fee_rate_milli_msat_p25,
    percentileDisc(fee_rate_milli_msat, 0.50) AS fee_rate_milli_msat_p50,
    percentileDisc(fee_rate_milli_msat, 0.75) AS fee_rate_milli_msat_p75,

    percentileDisc(partner_fee_rate_milli_msat, 0.25) AS partner_fee_rate_milli_msat_p25,
    percentileDisc(partner_fee_rate_milli_msat, 0.50) AS partner_fee_rate_milli_msat_p50,
    percentileDisc(partner_fee_rate_milli_msat, 0.75) AS partner_fee_rate_milli_msat_p75,

    percentileDisc(fee_base_msat, 0.25) AS fee_base_msat_p25,
    percentileDisc(fee_base_msat, 0.50) AS fee_base_msat_p50,
    percentileDisc(fee_base_msat, 0.75) AS fee_base_msat_p75,

    percentileDisc(partner_fee_base_msat, 0.25) AS partner_fee_base_msat_p25,
    percentileDisc(partner_fee_base_msat, 0.50) AS partner_fee_base_msat_p50,
    percentileDisc(partner_fee_base_msat, 0.75) AS partner_fee_base_msat_p75

SET
  n.degree = degree,
  n.capacity = capacity,

  n.capacity_p25 = capacity_p25,
  n.capacity_p50 = capacity_p50,
  n.capacity_p75 = capacity_p75,

  n.fee_rate_milli_msat_p25 = fee_rate_milli_msat_p25,
  n.fee_rate_milli_msat_p50 = fee_rate_milli_msat_p50,
  n.fee_rate_milli_msat_p75 = fee_rate_milli_msat_p75,

  n.fee_base_msat_p25 = fee_base_msat_p25,
  n.fee_base_msat_p50 = fee_base_msat_p50,
  n.fee_base_msat_p75 = fee_base_msat_p75,

  n.partner_fee_rate_milli_msat_p25 = partner_fee_rate_milli_msat_p25,
  n.partner_fee_rate_milli_msat_p50 = partner_fee_rate_milli_msat_p50,
  n.partner_fee_rate_milli_msat_p75 = partner_fee_rate_milli_msat_p75,

  n.partner_fee_base_msat_p25 = partner_fee_base_msat_p25,
  n.partner_fee_base_msat_p50 = partner_fee_base_msat_p50,
  n.partner_fee_base_msat_p75 = partner_fee_base_msat_p75
;
