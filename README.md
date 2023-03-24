### CIMS-Backend

An express api for [cims](https://github.com/michael86/inventory-management-system-web-app)

## Notes

Need to send unix timestamp to invoice route and update db to accept unix as a timestamp

## To do

...

## reset user data

TRUNCATE `history`; TRUNCATE `history_locations`; TRUNCATE `invoice_company`; TRUNCATE `invoice_item`; TRUNCATE `invoice_items`; TRUNCATE `invoice_specific`; TRUNCATE `invoice_specifics`; TRUNCATE `locations`; TRUNCATE `reset_tokens`; TRUNCATE `stock`; TRUNCATE `stock_company`; TRUNCATE `stock_histories`; TRUNCATE `stock_locations`; TRUNCATE `user_invoices`; TRUNCATE `user_reset`; TRUNCATE `user_stock`;
