WITH product as (
    SELECT
        parcel_id
        , SUM(quantity) as qty
        , COUNT(model_name) as nb_model
    FROM {{ ref("stg_circle__parcel_product")}}
    GROUP BY parcel_id
)


SELECT
    p.*
    , EXTRACT(MONTH FROM date_purchase) as month_purchase
    , {{ status(date_purchase, date_shipping, date_delivery, date_cancelled) }} as status
    , DATE_DIFF(date_shipping, date_purchase, DAY) as expedition_time
    , DATE_DIFF(date_delivery, date_shipping, DAY) as transport_time
    , DATE_DIFF(date_delivery, date_purchase, DAY) as delivery_time
    , IF(DATE_DIFF(date_delivery, date_purchase, DAY) > 5, (DATE_DIFF(date_delivery, date_purchase, DAY) - 5), NULL) as delay
    , pr.qty
    , pr.nb_model
FROM {{ ref("stg_circle__parcel")}} as p
JOIN product as pr
    using(parcel_id)