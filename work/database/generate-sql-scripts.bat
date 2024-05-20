python csv2sql/csv2sql.py csv/init_data/admin_users.csv -t users -o sql-output/init_data/V0000.00.00_0011__ADMIN_USERS.sql
python csv2sql/csv2sql.py csv/init_data/amin_tenants.csv -t tenants -o sql-output/init_data/V0000.00.00_0012__ADMIN_TENANTS.sql
python csv2sql/csv2sql.py csv/init_data/admin_users_tenants.csv -t users_tenants -o sql-output/init_data/V0000.00.00_0013__ADMIN_USERS_TENANTS.sql

python csv2sql/csv2sql.py csv/catalogs/countries.csv -t countries_pub_ctlg -o sql-output/catalogs/V0000.00.00_0021__COUNTRIES.sql
python csv2sql/csv2sql.py csv/catalogs/provinces.csv -t administrative_divisions_pub_ctlg -o sql-output/catalogs/V0000.00.00_0022__PROVINCES.sql
python csv2sql/csv2sql.py csv/catalogs/cities.csv -t cities_pub_ctlg -o sql-output/catalogs/V0000.00.00_0023__CITIES.sql

python csv2sql/csv2sql.py csv/test_data/users.csv -t users -o sql-output/test_data/V0000.00.00_1001__USERS.sql
python csv2sql/csv2sql.py csv/test_data/tenants.csv -t tenants -o sql-output/test_data/V0000.00.00_1002__TENANTS.sql
python csv2sql/csv2sql.py csv/test_data/users_tenants.csv -t users_tenants -o sql-output/test_data/V0000.00.00_1003__USERS_TENANTS.sql

python csv2sql/csv2sql.py csv/test_data/birds.csv -t birds -o sql-output/test_data/V0000.00.00_2001__BIRDS.sql
python csv2sql/csv2sql.py csv/test_data/sightings.csv -t sightings -o sql-output/test_data/V0000.00.00_2002__SIGHTINGS.sql
