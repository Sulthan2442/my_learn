{{ config(materialized='table') }}

select 
* from {{source('datafeed_mydata','SUPPLIERS')}}