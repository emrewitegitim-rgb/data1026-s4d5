{% macro status(date_purchase, date_shipping, date_delivery, date_cancelled) %}
    CASE
        WHEN date_cancelled is not null THEN '4-Cancelled'
        WHEN date_delivery is not null THEN '3-Delivered'
        WHEN date_shipping is not null THEN '2-Shipped'
        WHEN date_purchase is not null THEN '1-In progress'
        ELSE null
    END
{% endmacro %}