CREATE TABLE passenger_class(
    id  INT NOT NULL PRIMARY KEY,
    passenger_id INT NOT NULL FOREIGN KEY REFERENCES passenger(id)
);