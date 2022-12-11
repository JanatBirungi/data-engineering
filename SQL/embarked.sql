CREATE TABLE embarked(
    id  SERIAL NOT NULL PRIMARY KEY,
    port_of_embarkation TEXT,
    port_initial TEXT
);
INSERT INTO embarked(port_of_embarkation) VALUES ('Cherbourg','C');
INSERT INTO embarked(port_of_embarkation) VALUES ('Queenstown','Q');
INSERT INTO embarked(port_of_embarkation) VALUES ('Southampton','S');

