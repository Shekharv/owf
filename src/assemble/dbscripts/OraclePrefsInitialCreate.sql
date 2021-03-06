-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: changelog.groovy
-- Ran at: 12/18/12 10:40 AM

-- Liquibase version: 2.0.1
-- *********************************************************************

-- Create Database Lock Table
CREATE TABLE DATABASECHANGELOGLOCK (ID INTEGER NOT NULL, LOCKED NUMBER(1) NOT NULL, LOCKGRANTED TIMESTAMP, LOCKEDBY VARCHAR2(255), CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

INSERT INTO DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

-- Lock Database
-- Create Database Change Log Table
CREATE TABLE DATABASECHANGELOG (ID VARCHAR2(63) NOT NULL, AUTHOR VARCHAR2(63) NOT NULL, FILENAME VARCHAR2(200) NOT NULL, DATEEXECUTED TIMESTAMP NOT NULL, ORDEREXECUTED INTEGER NOT NULL, EXECTYPE VARCHAR2(10) NOT NULL, MD5SUM VARCHAR2(35), DESCRIPTION VARCHAR2(255), COMMENTS VARCHAR2(255), TAG VARCHAR2(255), LIQUIBASE VARCHAR2(20), CONSTRAINT PK_DATABASECHANGELOG PRIMARY KEY (ID, AUTHOR, FILENAME));

-- Changeset changelog_3.7.0.groovy::3.7.0-1::owf::(Checksum: 3:91f62e5cd654b47f3630076d47e2334f)
create table dashboard (id number(19,0) not null, version number(19,0) not null, isdefault number(1,0) not null, dashboard_position number(10,0) not null, altered_by_admin number(1,0) not null, guid varchar2(255 char) not null unique, column_count number(10,0) not null, layout varchar2(9 char) not null, name varchar2(200 char) not null, user_id number(19,0) not null, primary key (id));

create table dashboard_widget_state (id number(19,0) not null, version number(19,0) not null, region varchar2(15 char) not null, button_opened number(1,0) not null, z_index number(10,0) not null, person_widget_definition_id number(19,0), minimized number(1,0) not null, unique_id varchar2(255 char) not null unique, height number(10,0) not null, pinned number(1,0) not null, name varchar2(200 char) not null, widget_guid varchar2(255 char), column_pos number(10,0) not null, width number(10,0) not null, button_id varchar2(255 char), collapsed number(1,0) not null, maximized number(1,0) not null, state_position number(10,0) not null, active number(1,0) not null, dashboard_id number(19,0) not null, y number(10,0) not null, x number(10,0) not null, primary key (id));

create table domain_mapping (id number(19,0) not null, version number(19,0) not null, src_id number(19,0) not null, src_type varchar2(255 char) not null, relationship_type varchar2(8 char), dest_id number(19,0) not null, dest_type varchar2(255 char) not null, primary key (id));

create table eventing_connections (id number(19,0) not null, version number(19,0) not null, dashboard_widget_state_id number(19,0) not null, widget_guid varchar2(255 char) not null, eventing_connections_idx number(10,0), primary key (id));

create table owf_group (id number(19,0) not null, version number(19,0) not null, status varchar2(8 char) not null, email varchar2(255 char), description varchar2(255 char), name varchar2(200 char) not null, automatic number(1,0) not null, primary key (id));

create table owf_group_people (person_id number(19,0) not null, group_id number(19,0) not null, primary key (group_id, person_id));

create table person (id number(19,0) not null, version number(19,0) not null, enabled number(1,0) not null, user_real_name varchar2(200 char) not null, username varchar2(200 char) not null unique, last_login timestamp, email_show number(1,0) not null, email varchar2(255 char), prev_login timestamp, description varchar2(255 char), primary key (id));

create table person_widget_definition (id number(19,0) not null, version number(19,0) not null, person_id number(19,0) not null, visible number(1,0) not null, pwd_position number(10,0) not null, widget_definition_id number(19,0) not null, primary key (id), unique (person_id, widget_definition_id));

create table preference (id number(19,0) not null, version number(19,0) not null, value clob not null, path varchar2(200 char) not null, user_id number(19,0) not null, namespace varchar2(200 char) not null, primary key (id), unique (path, namespace, user_id));

create table requestmap (id number(19,0) not null, version number(19,0) not null, url varchar2(255 char) not null unique, config_attribute varchar2(255 char) not null, primary key (id));

create table role (id number(19,0) not null, version number(19,0) not null, authority varchar2(255 char) not null unique, description varchar2(255 char) not null, primary key (id));

create table role_people (role_id number(19,0) not null, person_id number(19,0) not null, primary key (role_id, person_id));

create table tag_links (id number(19,0) not null, version number(19,0) not null, pos number(19,0), visible number(1,0), tag_ref number(19,0) not null, tag_id number(19,0) not null, type varchar2(255 char) not null, editable number(1,0), primary key (id));

create table tags (id number(19,0) not null, version number(19,0) not null, name varchar2(255 char) not null unique, primary key (id));

create table widget_definition (id number(19,0) not null, version number(19,0) not null, visible number(1,0) not null, image_url_large varchar2(2083 char) not null, image_url_small varchar2(2083 char) not null, singleton number(1,0) not null, width number(10,0) not null, widget_version varchar2(2083 char) not null, height number(10,0) not null, widget_url varchar2(2083 char) not null, widget_guid varchar2(255 char) not null unique, display_name varchar2(200 char) not null, primary key (id));

alter table dashboard add constraint FKC18AEA948656347D foreign key (user_id) references person;

alter table dashboard_widget_state add constraint FKB6440EA192BD68BB foreign key (person_widget_definition_id) references person_widget_definition;

alter table dashboard_widget_state add constraint FKB6440EA1CA944B81 foreign key (dashboard_id) references dashboard;

alter table eventing_connections add constraint FKBCC1569EB20FFC4B foreign key (dashboard_widget_state_id) references dashboard_widget_state;

alter table owf_group_people add constraint FK2811370C1F5E0B3 foreign key (person_id) references person;

alter table owf_group_people add constraint FK28113703B197B21 foreign key (group_id) references owf_group;

alter table person_widget_definition add constraint FK6F5C17C4C1F5E0B3 foreign key (person_id) references person;

alter table person_widget_definition add constraint FK6F5C17C4293A835C foreign key (widget_definition_id) references widget_definition;

alter table preference add constraint FKA8FCBCDB8656347D foreign key (user_id) references person;

alter table role_people add constraint FK28B75E7870B353 foreign key (role_id) references role;

alter table role_people add constraint FK28B75E78C1F5E0B3 foreign key (person_id) references person;

alter table tag_links add constraint FK7C35D6D45A3B441D foreign key (tag_id) references tags;

create sequence hibernate_sequence;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Custom SQL', 'EXECUTED', 'changelog_3.7.0.groovy', '3.7.0-1', '2.0.1', '3:91f62e5cd654b47f3630076d47e2334f', 1);

-- Changeset changelog_3.8.0.groovy::3.8.0-1::owf::(Checksum: 3:d66582e573cee33f424ebb952decd92d)
ALTER TABLE dashboard MODIFY user_id NULL;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Drop Not-Null Constraint', 'EXECUTED', 'changelog_3.8.0.groovy', '3.8.0-1', '2.0.1', '3:d66582e573cee33f424ebb952decd92d', 2);

-- Changeset changelog_3.8.0.groovy::3.8.0-2::owf::(Checksum: 3:43600e1eebd0b612def9a76758daa403)
-- Added description column into Dashboard Table
ALTER TABLE dashboard ADD description VARCHAR2(255);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Added description column into Dashboard Table', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_3.8.0.groovy', '3.8.0-2', '2.0.1', '3:43600e1eebd0b612def9a76758daa403', 3);

-- Changeset changelog_3.8.0.groovy::3.8.0-3::owf::(Checksum: 3:cd0a0df59ba7079055230181279b9fe5)
ALTER TABLE dashboard ADD created_by_id NUMBER(38,0);

ALTER TABLE dashboard ADD created_date TIMESTAMP;

ALTER TABLE dashboard ADD edited_by_id NUMBER(38,0);

ALTER TABLE dashboard ADD edited_date TIMESTAMP;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_3.8.0.groovy', '3.8.0-3', '2.0.1', '3:cd0a0df59ba7079055230181279b9fe5', 4);

-- Changeset changelog_3.8.0.groovy::3.8.0-4::owf::(Checksum: 3:b98ec98220fc4669acb11cc65cba959b)
ALTER TABLE dashboard ADD CONSTRAINT FKC18AEA94372CC5A FOREIGN KEY (created_by_id) REFERENCES person (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Add Foreign Key Constraint', 'EXECUTED', 'changelog_3.8.0.groovy', '3.8.0-4', '2.0.1', '3:b98ec98220fc4669acb11cc65cba959b', 5);

-- Changeset changelog_3.8.0.groovy::3.8.0-5::owf::(Checksum: 3:30cd6eb8e32c5bb622cd48a6730e86e1)
ALTER TABLE dashboard ADD CONSTRAINT FKC18AEA947028B8DB FOREIGN KEY (edited_by_id) REFERENCES person (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Add Foreign Key Constraint', 'EXECUTED', 'changelog_3.8.0.groovy', '3.8.0-5', '2.0.1', '3:30cd6eb8e32c5bb622cd48a6730e86e1', 6);

-- Changeset changelog_3.8.0.groovy::3.8.0-9::owf::(Checksum: 3:c663eb75620ae74e0f7ca517d8bd4c1b)
ALTER TABLE widget_definition MODIFY widget_version NULL;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Drop Not-Null Constraint', 'EXECUTED', 'changelog_3.8.0.groovy', '3.8.0-9', '2.0.1', '3:c663eb75620ae74e0f7ca517d8bd4c1b', 7);

-- Changeset changelog_4.0.0.groovy::4.0.0-3::owf::(Checksum: 3:d066b39ebec901b63dbe5b674825449d)
-- Added defaultSettings column into Dashboard Table
ALTER TABLE dashboard ADD default_settings CLOB;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Added defaultSettings column into Dashboard Table', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_4.0.0.groovy', '4.0.0-3', '2.0.1', '3:d066b39ebec901b63dbe5b674825449d', 8);

-- Changeset changelog_4.0.0.groovy::4.0.0-4::owf::(Checksum: 3:c4ccbcf8a10f33b5063af97a9d15d28c)
-- Added background column for WidgetDefinition
ALTER TABLE widget_definition ADD background NUMBER(1);

UPDATE widget_definition SET background = 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Added background column for WidgetDefinition', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_4.0.0.groovy', '4.0.0-4', '2.0.1', '3:c4ccbcf8a10f33b5063af97a9d15d28c', 9);

-- Changeset changelog_4.0.0.groovy::4.0.0-47::owf::(Checksum: 3:967a5a6cb7f1d94dfef9beb90b77e1e5)
-- Added showLaunchMenu column into Dashboard Table
ALTER TABLE dashboard ADD show_launch_menu NUMBER(1) DEFAULT 0;

UPDATE dashboard SET show_launch_menu = 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Added showLaunchMenu column into Dashboard Table', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_4.0.0.groovy', '4.0.0-47', '2.0.1', '3:967a5a6cb7f1d94dfef9beb90b77e1e5', 10);

-- Changeset changelog_4.0.0.groovy::4.0.0-48::owf::(Checksum: 3:43eac589305fd819d29fe84a43414c3f)
-- Create widget type table and linking table
CREATE TABLE widget_type (id NUMBER(38,0) NOT NULL, version NUMBER(38,0) NOT NULL, name VARCHAR2(255) NOT NULL, CONSTRAINT widget_typePK PRIMARY KEY (id));

CREATE TABLE widget_definition_widget_types (widget_definition_id NUMBER(38,0) NOT NULL, widget_type_id NUMBER(38,0) NOT NULL);

ALTER TABLE widget_definition_widget_types ADD PRIMARY KEY (widget_definition_id, widget_type_id);

ALTER TABLE widget_definition_widget_types ADD CONSTRAINT FK8A59D92F293A835C FOREIGN KEY (widget_definition_id) REFERENCES widget_definition (id);

ALTER TABLE widget_definition_widget_types ADD CONSTRAINT FK8A59D92FD46C6F7C FOREIGN KEY (widget_type_id) REFERENCES widget_type (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create widget type table and linking table', SYSTIMESTAMP, 'Create Table (x2), Add Primary Key, Add Foreign Key Constraint (x2)', 'EXECUTED', 'changelog_4.0.0.groovy', '4.0.0-48', '2.0.1', '3:43eac589305fd819d29fe84a43414c3f', 11);

-- Changeset changelog_4.0.0.groovy::4.0.0-51::owf::(Checksum: 3:dc8cf89d14b68c19d487908ef28c89b1)
-- Add widget types to table
INSERT INTO widget_type (id, name, version) VALUES (1, 'standard', 0);

INSERT INTO widget_type (id, name, version) VALUES (2, 'administration', 0);

INSERT INTO widget_type (id, name, version) VALUES (3, 'marketplace', 0);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add widget types to table', SYSTIMESTAMP, 'Insert Row (x3)', 'EXECUTED', 'changelog_4.0.0.groovy', '4.0.0-51', '2.0.1', '3:dc8cf89d14b68c19d487908ef28c89b1', 12);

-- Changeset changelog_4.0.0.groovy::4.0.0-56::owf::(Checksum: 3:7e4d6568d91e79149f8b895501eb8579)
-- Updating display_name column to 256 chars
ALTER TABLE widget_definition MODIFY display_name VARCHAR2(256);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Updating display_name column to 256 chars', SYSTIMESTAMP, 'Modify data type', 'EXECUTED', 'changelog_4.0.0.groovy', '4.0.0-56', '2.0.1', '3:7e4d6568d91e79149f8b895501eb8579', 13);

-- Changeset changelog_5.0.0.groovy::5.0.0-1::owf::(Checksum: 3:42d9c4bdcdff38a4fbe40bd1ec78d9b1)
-- Add display name to group
ALTER TABLE owf_group ADD display_name VARCHAR2(200);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add display name to group', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_5.0.0.groovy', '5.0.0-1', '2.0.1', '3:42d9c4bdcdff38a4fbe40bd1ec78d9b1', 14);

-- Changeset changelog_5.0.0.groovy::5.0.0-3::owf::(Checksum: 3:aa2aca168ad6eaeea8509fd642d8c17b)
-- Add metric widget types to table
INSERT INTO widget_type (id, name, version) VALUES (4, 'metric', 0);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add metric widget types to table', SYSTIMESTAMP, 'Insert Row', 'EXECUTED', 'changelog_5.0.0.groovy', '5.0.0-3', '2.0.1', '3:aa2aca168ad6eaeea8509fd642d8c17b', 15);

-- Changeset changelog_6.0.0.groovy::6.0.0-1::owf::(Checksum: 3:b7a17650e4cfde415fdbbcc4f2bd1317)
-- Add universal_name to widgetdefinition
ALTER TABLE widget_definition ADD universal_name VARCHAR2(255);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add universal_name to widgetdefinition', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-1', '2.0.1', '3:b7a17650e4cfde415fdbbcc4f2bd1317', 16);

-- Changeset changelog_6.0.0.groovy::6.0.0-2::owf::(Checksum: 3:30ea4354058c7a09bfafb6acabfd1e33)
-- Add layoutConfig to dashboard
ALTER TABLE dashboard ADD layout_config CLOB;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add layoutConfig to dashboard', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-2', '2.0.1', '3:30ea4354058c7a09bfafb6acabfd1e33', 17);

-- Changeset changelog_6.0.0.groovy::6.0.0-3::owf::(Checksum: 3:6ce1db42048bc63ece1be0c3f4669a52)
-- Add descriptor_url to widgetdefinition
ALTER TABLE widget_definition ADD descriptor_url VARCHAR2(2083);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add descriptor_url to widgetdefinition', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-3', '2.0.1', '3:6ce1db42048bc63ece1be0c3f4669a52', 18);

-- Changeset changelog_6.0.0.groovy::6.0.0-4::owf::(Checksum: 3:4e940a0bdfea36b98c62330e4b373dd3)
-- Remove EventingConnections table and association with DashboardWidgetState
DROP TABLE eventing_connections;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove EventingConnections table and association with DashboardWidgetState', SYSTIMESTAMP, 'Drop Table', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-4', '2.0.1', '3:4e940a0bdfea36b98c62330e4b373dd3', 19);

-- Changeset changelog_6.0.0.groovy::6.0.0-5::owf::(Checksum: 3:2c40b74eb7eb29a286ac641320a97b4d)
-- Create intent table
CREATE TABLE intent (id NUMBER(38,0) NOT NULL, version NUMBER(38,0) NOT NULL, action VARCHAR2(255) NOT NULL, CONSTRAINT intentPK PRIMARY KEY (id), UNIQUE (action));

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create intent table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-5', '2.0.1', '3:2c40b74eb7eb29a286ac641320a97b4d', 20);

-- Changeset changelog_6.0.0.groovy::6.0.0-6::owf::(Checksum: 3:008f636cf428abbd60459975d28e62a1)
-- Create intent_data_type table
CREATE TABLE intent_data_type (id NUMBER(38,0) NOT NULL, version NUMBER(38,0) NOT NULL, data_type VARCHAR2(255) NOT NULL, CONSTRAINT intent_data_typePK PRIMARY KEY (id));

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create intent_data_type table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-6', '2.0.1', '3:008f636cf428abbd60459975d28e62a1', 21);

-- Changeset changelog_6.0.0.groovy::6.0.0-7::owf::(Checksum: 3:b462f738ef9c30634a0a47d245d16a59)
-- Create intent_data_types table
CREATE TABLE intent_data_types (intent_data_type_id NUMBER(38,0) NOT NULL, intent_id NUMBER(38,0) NOT NULL);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create intent_data_types table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-7', '2.0.1', '3:b462f738ef9c30634a0a47d245d16a59', 22);

-- Changeset changelog_6.0.0.groovy::6.0.0-8::owf::(Checksum: 3:ee497899a41d5cc2798af5cfc277aecb)
-- Add foreign constraint for intent_data_type_id and intent_id in intent_data_types table
ALTER TABLE intent_data_types ADD CONSTRAINT FK8A59132FD46C6FAA FOREIGN KEY (intent_data_type_id) REFERENCES intent_data_type (id);

ALTER TABLE intent_data_types ADD CONSTRAINT FK8A59D92FD46C6FAA FOREIGN KEY (intent_id) REFERENCES intent (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add foreign constraint for intent_data_type_id and intent_id in intent_data_types table', SYSTIMESTAMP, 'Add Foreign Key Constraint (x2)', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-8', '2.0.1', '3:ee497899a41d5cc2798af5cfc277aecb', 23);

-- Changeset changelog_6.0.0.groovy::6.0.0-9::owf::(Checksum: 3:8dda2a300eac867527577e37dabf3187)
-- Create widget_def_intent table
CREATE TABLE widget_def_intent (id NUMBER(38,0) NOT NULL, version NUMBER(38,0) NOT NULL, receive NUMBER(1) NOT NULL, send NUMBER(1) NOT NULL, intent_id NUMBER(38,0) NOT NULL, widget_definition_id NUMBER(38,0) NOT NULL, CONSTRAINT widget_def_intentPK PRIMARY KEY (id));

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create widget_def_intent table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-9', '2.0.1', '3:8dda2a300eac867527577e37dabf3187', 24);

-- Changeset changelog_6.0.0.groovy::6.0.0-10::owf::(Checksum: 3:e5d364edc24ace7b9b89d3854bb70408)
-- Add foreign constraint for widget_definition_id in widget_def_intent table
ALTER TABLE widget_def_intent ADD CONSTRAINT FK8A59D92FD46C6FAB FOREIGN KEY (widget_definition_id) REFERENCES widget_definition (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add foreign constraint for widget_definition_id in widget_def_intent table', SYSTIMESTAMP, 'Add Foreign Key Constraint', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-10', '2.0.1', '3:e5d364edc24ace7b9b89d3854bb70408', 25);

-- Changeset changelog_6.0.0.groovy::6.0.0-11::owf::(Checksum: 3:fcf69ebd060340afd1483c2f4588f456)
-- Add foreign constraint for intent_id in widget_definition_intent table
ALTER TABLE widget_def_intent ADD CONSTRAINT FK8A59D92FD46C6FAC FOREIGN KEY (intent_id) REFERENCES intent (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add foreign constraint for intent_id in widget_definition_intent table', SYSTIMESTAMP, 'Add Foreign Key Constraint', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-11', '2.0.1', '3:fcf69ebd060340afd1483c2f4588f456', 26);

-- Changeset changelog_6.0.0.groovy::6.0.0-12::owf::(Checksum: 3:05c50cdf2e21818c6986e5ef2d8c9f50)
-- Create widget_def_intent_data_types table
CREATE TABLE widget_def_intent_data_types (intent_data_type_id NUMBER(38,0) NOT NULL, widget_definition_intent_id NUMBER(38,0) NOT NULL);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create widget_def_intent_data_types table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-12', '2.0.1', '3:05c50cdf2e21818c6986e5ef2d8c9f50', 27);

-- Changeset changelog_6.0.0.groovy::6.0.0-13::owf::(Checksum: 3:3250f92e3b85fec3db493d11b53445e2)
-- Add foreign constraint for intent_data_type_id and widget_definition_intent_id in widget_def_intent_data_types table
ALTER TABLE widget_def_intent_data_types ADD CONSTRAINT FK8A59D92FD41A6FAD FOREIGN KEY (intent_data_type_id) REFERENCES intent_data_type (id);

ALTER TABLE widget_def_intent_data_types ADD CONSTRAINT FK8A59D92FD46C6FAD FOREIGN KEY (widget_definition_intent_id) REFERENCES widget_def_intent (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add foreign constraint for intent_data_type_id and widget_definition_intent_id in widget_def_intent_data_types table', SYSTIMESTAMP, 'Add Foreign Key Constraint (x2)', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-13', '2.0.1', '3:3250f92e3b85fec3db493d11b53445e2', 28);

-- Changeset changelog_6.0.0.groovy::6.0.0-14::owf::(Checksum: 3:897a5aa2802104b8f90bcde737c47002)
-- Add intentConfig column to dashboard table
ALTER TABLE dashboard ADD intent_config CLOB;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add intentConfig column to dashboard table', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-14', '2.0.1', '3:897a5aa2802104b8f90bcde737c47002', 29);

-- Changeset changelog_6.0.0.groovy::6.0.0-15::owf::(Checksum: 3:a58c7f9ab7dcc8c733d3a16c25adc558)
-- Added description column into Widget Definition table
ALTER TABLE widget_definition ADD description VARCHAR2(255) DEFAULT '';

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Added description column into Widget Definition table', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-15', '2.0.1', '3:a58c7f9ab7dcc8c733d3a16c25adc558', 30);

-- Changeset changelog_6.0.0.groovy::6.0.0-16::owf::(Checksum: 3:9624d22cdbed36b5bbce5da92bdb1bfc)
-- Add groupWidget property to personwidgetdefinition
ALTER TABLE person_widget_definition ADD group_widget NUMBER(1) DEFAULT 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add groupWidget property to personwidgetdefinition', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-16', '2.0.1', '3:9624d22cdbed36b5bbce5da92bdb1bfc', 31);

-- Changeset changelog_6.0.0.groovy::6.0.0-17::owf::(Checksum: 3:92a97333d2f7b5f17e0a541712847a54)
-- Add favorite property to personwidgetdefinition
ALTER TABLE person_widget_definition ADD favorite NUMBER(1) DEFAULT 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add favorite property to personwidgetdefinition', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-17', '2.0.1', '3:92a97333d2f7b5f17e0a541712847a54', 32);

-- Changeset changelog_6.0.0.groovy::6.0.0-44::owf::(Checksum: 3:a0a7528d5494cd0f02b38b3f99b2cfe4)
ALTER TABLE dashboard MODIFY layout NULL;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Drop Not-Null Constraint', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-44', '2.0.1', '3:a0a7528d5494cd0f02b38b3f99b2cfe4', 33);

-- Changeset changelog_6.0.0.groovy::6.0.0-53::owf::(Checksum: 3:9f398a44008d12aee688e347940b7adf)
-- Add locked property to dashboard
ALTER TABLE dashboard ADD locked NUMBER(1) DEFAULT 0;

UPDATE dashboard SET locked = 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add locked property to dashboard', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-53', '2.0.1', '3:9f398a44008d12aee688e347940b7adf', 34);

-- Changeset changelog_6.0.0.groovy::6.0.0-55::owf::(Checksum: 3:2aa790687f711ca1d930c1aa24fadd0c)
-- Add display name field to pwd
ALTER TABLE person_widget_definition ADD display_name VARCHAR2(256);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add display name field to pwd', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-55', '2.0.1', '3:2aa790687f711ca1d930c1aa24fadd0c', 35);

-- Changeset changelog_6.0.0.groovy::6.0.0-56::owf::(Checksum: 3:ca86586d796b6e61467c6fc7cb0a787c)
-- Add disabled field to pwd
ALTER TABLE person_widget_definition ADD disabled NUMBER(1) DEFAULT 0;

UPDATE person_widget_definition SET disabled = 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add disabled field to pwd', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_6.0.0.groovy', '6.0.0-56', '2.0.1', '3:ca86586d796b6e61467c6fc7cb0a787c', 36);

-- Changeset changelog_7.0.0.groovy::7.0.0-1::owf::(Checksum: 3:9c64b0b8b8cb507555f0c02c00cb382b)
-- Expand a widget definition's description field to 4000 to match Marketplace
ALTER TABLE widget_definition MODIFY description VARCHAR2(4000);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Expand a widget definition''s description field to 4000 to match Marketplace', SYSTIMESTAMP, 'Modify data type', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-1', '2.0.1', '3:9c64b0b8b8cb507555f0c02c00cb382b', 37);

-- Changeset changelog_7.0.0.groovy::7.0.0-2::owf::(Checksum: 3:d1ab9c56671573cf7cde5a4e7c13652c)
-- Remove DashboardWidgetState since it is no longer used.
DROP TABLE dashboard_widget_state;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove DashboardWidgetState since it is no longer used.', SYSTIMESTAMP, 'Drop Table', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-2', '2.0.1', '3:d1ab9c56671573cf7cde5a4e7c13652c', 38);

-- Changeset changelog_7.0.0.groovy::7.0.0-4::owf::(Checksum: 3:21b5b103a5b9e7134b2bbb0a7686e3cf)
-- Remove show_launch_menu since it is no longer used.
ALTER TABLE dashboard DROP COLUMN show_launch_menu;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove show_launch_menu since it is no longer used.', SYSTIMESTAMP, 'Drop Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-4', '2.0.1', '3:21b5b103a5b9e7134b2bbb0a7686e3cf', 39);

-- Changeset changelog_7.0.0.groovy::7.0.0-5::owf::(Checksum: 3:634c7ed646b89e253102d12b6818c245)
-- Remove layout since it is no longer used.
ALTER TABLE dashboard DROP COLUMN layout;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove layout since it is no longer used.', SYSTIMESTAMP, 'Drop Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-5', '2.0.1', '3:634c7ed646b89e253102d12b6818c245', 40);

-- Changeset changelog_7.0.0.groovy::7.0.0-6::owf::(Checksum: 3:ef21c5e1a70b81160e2ed6989fc1afa6)
-- Remove intent_config since it is no longer used.
ALTER TABLE dashboard DROP COLUMN intent_config;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove intent_config since it is no longer used.', SYSTIMESTAMP, 'Drop Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-6', '2.0.1', '3:ef21c5e1a70b81160e2ed6989fc1afa6', 41);

-- Changeset changelog_7.0.0.groovy::7.0.0-7::owf::(Checksum: 3:9ee1cd65b85caaca3178939bac1e0fcf)
-- Remove default_settings since it is no longer used.
ALTER TABLE dashboard DROP COLUMN default_settings;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove default_settings since it is no longer used.', SYSTIMESTAMP, 'Drop Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-7', '2.0.1', '3:9ee1cd65b85caaca3178939bac1e0fcf', 42);

-- Changeset changelog_7.0.0.groovy::7.0.0-8::owf::(Checksum: 3:ef688a16b0055a8024a489393bcfc987)
-- Remove column_count since it is no longer used.
ALTER TABLE dashboard DROP COLUMN column_count;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Remove column_count since it is no longer used.', SYSTIMESTAMP, 'Drop Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-8', '2.0.1', '3:ef688a16b0055a8024a489393bcfc987', 43);

-- Changeset changelog_7.0.0.groovy::7.0.0-9::owf::(Checksum: 3:43e9c996af93d8cface8845446b8a525)
-- Create stack table
CREATE TABLE stack (id NUMBER(38,0) NOT NULL, version NUMBER(38,0) NOT NULL, name VARCHAR2(256) NOT NULL, description VARCHAR2(4000), stack_context VARCHAR2(200) NOT NULL, image_url VARCHAR2(2083), descriptor_url VARCHAR2(2083), CONSTRAINT stackPK PRIMARY KEY (id), UNIQUE (stack_context));

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create stack table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-9', '2.0.1', '3:43e9c996af93d8cface8845446b8a525', 44);

-- Changeset changelog_7.0.0.groovy::7.0.0-10::owf::(Checksum: 3:62f6507a0ac6b50fb383b2a47ba702a8)
-- Create stack_groups table
CREATE TABLE stack_groups (group_id NUMBER(38,0) NOT NULL, stack_id NUMBER(38,0) NOT NULL);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Create stack_groups table', SYSTIMESTAMP, 'Create Table', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-10', '2.0.1', '3:62f6507a0ac6b50fb383b2a47ba702a8', 45);

-- Changeset changelog_7.0.0.groovy::7.0.0-12::owf::(Checksum: 3:7a64e2e16d79e54338e9ec959602447a)
-- Add primary key constraint for group_id and stack_id in stack_groups table
ALTER TABLE stack_groups ADD CONSTRAINT pk_stack_groups PRIMARY KEY (group_id, stack_id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add primary key constraint for group_id and stack_id in stack_groups table', SYSTIMESTAMP, 'Add Primary Key', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-12', '2.0.1', '3:7a64e2e16d79e54338e9ec959602447a', 46);

-- Changeset changelog_7.0.0.groovy::7.0.0-13::owf::(Checksum: 3:0e9ce4f940d8f89b0fd983abc89ee775)
-- Add foreign key constraints for group_id and stack_id in stack_groups table
ALTER TABLE stack_groups ADD CONSTRAINT FK9584AB6B6B3A1281 FOREIGN KEY (stack_id) REFERENCES stack (id);

ALTER TABLE stack_groups ADD CONSTRAINT FK9584AB6B3B197B21 FOREIGN KEY (group_id) REFERENCES owf_group (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add foreign key constraints for group_id and stack_id in stack_groups table', SYSTIMESTAMP, 'Add Foreign Key Constraint (x2)', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-13', '2.0.1', '3:0e9ce4f940d8f89b0fd983abc89ee775', 47);

-- Changeset changelog_7.0.0.groovy::7.0.0-14::owf::(Checksum: 3:803b99533e3b4d760c15e2f1eca18e05)
-- Add stack_default field to group
ALTER TABLE owf_group ADD stack_default NUMBER(1) DEFAULT 0;

UPDATE owf_group SET stack_default = 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add stack_default field to group', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-14', '2.0.1', '3:803b99533e3b4d760c15e2f1eca18e05', 48);

-- Changeset changelog_7.0.0.groovy::7.0.0-16::owf::(Checksum: 3:e03b1ecbd7f5efdd372183d1eaaa8d27)
-- Insert OWF stack
insert into stack (id, version, name, description, stack_context, image_url) values (hibernate_sequence.nextval, 0, 'OWF', 'OWF Stack', 'owf', 'themes/common/images/owf.png');

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Insert OWF stack', SYSTIMESTAMP, 'Custom SQL', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-16', '2.0.1', '3:e03b1ecbd7f5efdd372183d1eaaa8d27', 49);

-- Changeset changelog_7.0.0.groovy::7.0.0-19::owf::(Checksum: 3:5232ecbd067faac92f9a4db665a544f5)
-- Insert OWF stack default group
insert into owf_group (id, version, automatic, name, status, stack_default) values (hibernate_sequence.nextval, 0, 0, 'ce86a612-c355-486e-9c9e-5252553cc58e', 'active', 1);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Insert OWF stack default group', SYSTIMESTAMP, 'Custom SQL', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-19', '2.0.1', '3:5232ecbd067faac92f9a4db665a544f5', 50);

-- Changeset changelog_7.0.0.groovy::7.0.0-21::owf::(Checksum: 3:32c56c09a37ffceb75742132f42ddf73)
insert into stack_groups (stack_id, group_id) values ((select id from stack where name = 'OWF'), (select id from owf_group where name = 'ce86a612-c355-486e-9c9e-5252553cc58e'));

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Custom SQL', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-21', '2.0.1', '3:32c56c09a37ffceb75742132f42ddf73', 51);

-- Changeset changelog_7.0.0.groovy::7.0.0-22::owf::(Checksum: 3:7146f45f54d8db1d72abb498d691cebb)
-- Add a reference to a host stack to dashboard records to track where user instances should appear
ALTER TABLE dashboard ADD stack_id NUMBER(38,0);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add a reference to a host stack to dashboard records to track where user instances should appear', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-22', '2.0.1', '3:7146f45f54d8db1d72abb498d691cebb', 52);

-- Changeset changelog_7.0.0.groovy::7.0.0-23::owf::(Checksum: 3:4d6a39028c8a5cc0a85b8b37fbf1b1fc)
-- Add foreign key constraint for stack_id in the dashboard table
ALTER TABLE dashboard ADD CONSTRAINT FKC18AEA946B3A1281 FOREIGN KEY (stack_id) REFERENCES stack (id);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add foreign key constraint for stack_id in the dashboard table', SYSTIMESTAMP, 'Add Foreign Key Constraint', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-23', '2.0.1', '3:4d6a39028c8a5cc0a85b8b37fbf1b1fc', 53);

-- Changeset changelog_7.0.0.groovy::7.0.0-24::owf::(Checksum: 3:f1e6830542a856459733effeca8aaa24)
-- Add a property to track the count of unique widgets present on the dashboards of a stack
ALTER TABLE stack ADD unique_widget_count NUMBER(38,0) DEFAULT '0';

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add a property to track the count of unique widgets present on the dashboards of a stack', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-24', '2.0.1', '3:f1e6830542a856459733effeca8aaa24', 54);

-- Changeset changelog_7.0.0.groovy::7.0.0-25::owf::(Checksum: 3:ac445082cf2ee5903046bef22276a996)
delete from stack_groups where stack_id = (select id from stack where name = 'OWF') and group_id = (select id from owf_group where name = 'ce86a612-c355-486e-9c9e-5252553cc58e');

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', '', SYSTIMESTAMP, 'Custom SQL', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-25', '2.0.1', '3:ac445082cf2ee5903046bef22276a996', 55);

-- Changeset changelog_7.0.0.groovy::7.0.0-26::owf::(Checksum: 3:74dc7504043a1f24e2d86d75a2dab571)
-- Delete OWF Stack Group
DELETE FROM owf_group  WHERE name like 'ce86a612-c355-486e-9c9e-5252553cc58e';

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Delete OWF Stack Group', SYSTIMESTAMP, 'Delete Data', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-26', '2.0.1', '3:74dc7504043a1f24e2d86d75a2dab571', 56);

-- Changeset changelog_7.0.0.groovy::7.0.0-27::owf::(Checksum: 3:cae136582b06f1ed04a6309814236cdc)
-- Delete OWF Stack
DELETE FROM stack  WHERE name like 'OWF';

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Delete OWF Stack', SYSTIMESTAMP, 'Delete Data', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-27', '2.0.1', '3:cae136582b06f1ed04a6309814236cdc', 57);

-- Changeset changelog_7.0.0.groovy::7.0.0-28::owf::(Checksum: 3:f1bf16779c9d7419bc7cc94e81687786)
-- Add user_widget field to person_widget_definition table
ALTER TABLE person_widget_definition ADD user_widget NUMBER(1) DEFAULT 0;

UPDATE person_widget_definition SET user_widget = 0;

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Add user_widget field to person_widget_definition table', SYSTIMESTAMP, 'Add Column', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-28', '2.0.1', '3:f1bf16779c9d7419bc7cc94e81687786', 58);

-- Changeset changelog_7.0.0.groovy::7.0.0-53::owf::(Checksum: 3:95913c657b14ecdbb8c9f85fc0a071b1)
-- Expand a dashboard's description field to 4000 to match Marketplace
ALTER TABLE dashboard MODIFY description VARCHAR2(4000);

INSERT INTO DATABASECHANGELOG (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('owf', 'Expand a dashboard''s description field to 4000 to match Marketplace', SYSTIMESTAMP, 'Modify data type', 'EXECUTED', 'changelog_7.0.0.groovy', '7.0.0-53', '2.0.1', '3:95913c657b14ecdbb8c9f85fc0a071b1', 59);

