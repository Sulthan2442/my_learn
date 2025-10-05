{{ config(materialized='table') }}

with tb1 as
(
    select 
    max(s_phone),
    concat(s_suppkey,'+',s_name) as profiles,
    cast(s_nationkey as int) as nationkey,
    s_acctbal as account,
    date_trunc ('month', d_date) as end_month,
    row_number() over(order by s_acctbal desc ) as r


 from {{source('datafeed_mydata','SUPPLIERS')}} s
 inner join {{source('datafeed_mydata','alpha')}} a
 on s.s_suppkey = a.d_dow
 group by concat(s_suppkey,'+',s_name),
 cast(s_nationkey as int),
 s_acctbal,
date_trunc ('month', d_date)
)
select * from tb1