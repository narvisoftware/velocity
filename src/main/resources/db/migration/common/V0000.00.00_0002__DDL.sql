CREATE TABLE users (
	id CHAR(32) NOT NULL,
	username TEXT NOT NULL,
	password_hash VARCHAR(128) NOT NULL,
	password_salt VARCHAR(128) NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	identity_card_number VARCHAR(50) NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT uk_username UNIQUE (username),
	CONSTRAINT fk_users_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_users_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);

CREATE TABLE tenants (
	id CHAR(32) NOT NULL,
	unique_code VARCHAR(10) NOT NULL,
	short_name TEXT NOT NULL,
	time_zone TEXT NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT uk_unique_code UNIQUE (unique_code),
	CONSTRAINT fk_tenant_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_tenant_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);

CREATE TABLE users_tenants (
	id CHAR(32) NOT NULL,
	user_id CHAR(32) NOT NULL,
	tenant_id CHAR(32) NOT NULL,
	is_owner boolean DEFAULT false,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT fk_ut_tenant FOREIGN KEY (tenant_id) REFERENCES tenants (id),
	CONSTRAINT fk_ut_user FOREIGN KEY (user_id) REFERENCES USERS (id),
	CONSTRAINT fk_u_tenants_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_u_tenants_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);

CREATE TABLE countries_pub_ctlg (
	id CHAR(32) NOT NULL,
	name TEXT NOT NULL,
	normalized_name TEXT NOT NULL,
	iso_alpha_2 VARCHAR(2) NOT NULL,
	iso_alpha_3 VARCHAR(3) NOT NULL,
	iso_numeric INTEGER NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT fk_countries_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_countries_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);
ALTER TABLE countries_pub_ctlg ADD UNIQUE (name);
ALTER TABLE countries_pub_ctlg ADD UNIQUE (iso_alpha_2);
ALTER TABLE countries_pub_ctlg ADD UNIQUE (iso_alpha_3);
ALTER TABLE countries_pub_ctlg ADD UNIQUE (iso_numeric);

CREATE TABLE administrative_divisions_pub_ctlg (
	id CHAR(32) NOT NULL,
	code VARCHAR(2) NOT NULL,
	name TEXT NOT NULL,
	normalized_name TEXT NOT NULL,
	country_id CHAR(32) NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT uk_administrative_division_code UNIQUE (code),
	CONSTRAINT uk_administrative_division_name UNIQUE (name),
	CONSTRAINT fk_administrative_division_countries FOREIGN KEY (country_id) REFERENCES countries_pub_ctlg (id),
	CONSTRAINT fk_administrative_division_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_administrative_division_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);

CREATE TABLE cities_pub_ctlg (
	id CHAR(32) NOT NULL,
	name TEXT NOT NULL,
	normalized_name TEXT NOT NULL,
	administrative_division_id CHAR(32) NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT fk_cities_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_cities_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id),
	CONSTRAINT fk_cities_region FOREIGN KEY (administrative_division_id) REFERENCES administrative_divisions_pub_ctlg (id)
);
CREATE INDEX idx_cities_name ON cities_pub_ctlg (name);

CREATE TABLE birds (
	id CHAR(32) NOT NULL,
	name TEXT NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT fk_birds_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_birds_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);

CREATE TABLE sightings (
	id CHAR(32) NOT NULL,
	bird_id CHAR(32) NOT NULL,
	location TEXT,
	tenant_owner CHAR(32) NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT '0',
	PRIMARY KEY (id),
	CONSTRAINT fk_sightings_birds FOREIGN KEY (bird_id) REFERENCES birds (id),
	CONSTRAINT fk_sightings_tenant FOREIGN KEY (tenant_owner) REFERENCES tenants (id),
	CONSTRAINT fk_sightings_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_sightings_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);

CREATE TABLE addresses (
	id CHAR(32) NOT NULL,
  index INTEGER NOT NULL DEFAULT 0,
	address TEXT,
	city_id CHAR(32),
	administrative_division_id CHAR(32),
	address_type VARCHAR(25),
	tenant_owner CHAR(32) NOT NULL,
	created_by CHAR(32) DEFAULT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT now(),
	last_modified_by CHAR(32) DEFAULT NULL,
	last_modified_on TIMESTAMP NOT NULL DEFAULT now(),
	version INTEGER NOT NULL DEFAULT '0',
	PRIMARY KEY (id),
	CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES cities_pub_ctlg (id),
	CONSTRAINT fk_addr_region FOREIGN KEY (administrative_division_id) REFERENCES administrative_divisions_pub_ctlg (id),
	CONSTRAINT fk_address_tenant FOREIGN KEY (tenant_owner) REFERENCES tenants (id),
	CONSTRAINT fk_address_user FOREIGN KEY (created_by) REFERENCES users (id),
	CONSTRAINT fk_address_user2 FOREIGN KEY (last_modified_by) REFERENCES users (id)
);
