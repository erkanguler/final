use master;


CREATE LOGIN ECommerce123 WITH PASSWORD = 'ECommerce_123';


USE ECommerce;
CREATE USER ECommerce123 FOR LOGIN ECommerce123;
ALTER ROLE db_owner ADD MEMBER [ECommerce123];
GRANT CONTROL ON DATABASE::ECommerce TO ECommerce123;

