-- select * from {{ ref("bronze_bookings") }}

select * from {{ ref("bronze_hosts") }}

-- select * from {{ ref("bronze_listings")}}