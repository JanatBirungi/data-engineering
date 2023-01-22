from sqlalchemy import create_engine, ForeignKey, Column, Integer, String, Boolean, Float
# create a database
engine = create_engine('sqlite:///voyager.db', echo = True)

from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()
from sqlalchemy.orm import relationship, sessionmaker
import pandas as pd 
import numpy as np 

# create classes, tables and relationships between the tables
class Cabin(Base):
   __tablename__ = 'cabin'

   id = Column(Integer, primary_key = True)
   cabin_name = Column(String)

class Embarked(Base):
   __tablename__ = 'embark'

   id = Column(Integer, primary_key = True)
   port_of_embarkation = Column(String)

class PassengerClass(Base):
   __tablename__ = 'passengerclass'

   id = Column(Integer, primary_key = True)
   passenger_class = Column(String)

class Survival(Base):
   __tablename__ = 'survival'

   id = Column(Integer, primary_key = True)
   survived = Column(String)

class Passenger(Base):
   __tablename__ = 'passengers'

   id = Column(Integer, primary_key = True)
   name = Column(String)
   sex = Column(String)
   age = Column(Float)
   sibsp = Column(Integer)
   parch = Column(Integer)
   survival_id = Column(Integer, ForeignKey('survival.id'))
   survivor = relationship("Survival", back_populates = "passengers")

Survival.passengers =  relationship("Passenger", order_by = Passenger.id, back_populates = "survivor")

class Payment(Base):
   __tablename__ = 'payments'

   id = Column(Integer, primary_key = True)
   passenger_id = Column(Integer, ForeignKey('passengers.id'))
   ticket = Column(String)
   fare = Column(Float)
   cabin_id = Column(Integer, ForeignKey('cabin.id'))
   embarked_id = Column(Integer, ForeignKey('embark.id'))
   passenger_class_id = Column(Integer, ForeignKey("passengerclass.id"))
   cabins = relationship("Cabin", back_populates = "payments")
   embarked = relationship("Embarked", back_populates = "payments")
   passengercl = relationship("PassengerClass", back_populates = "payments")
   passenger = relationship("Passenger", back_populates= "payments")

Cabin.payments = relationship("Payment", order_by = Payment.id, back_populates = "cabins")
Embarked.payments = relationship("Payment", order_by = Payment.id, back_populates = "embarked")
PassengerClass.payments = relationship("Payment", order_by = Payment.id, back_populates = "passengercl")
Passenger.payments = relationship("Payment", order_by = Payment.id, back_populates = "passenger")

Base.metadata.create_all(engine)

# create a session to connect to the database
Session = sessionmaker(bind=engine)
session = Session()

# add data to passengerclass table
rows = [
    PassengerClass(passenger_class = 'First Class'),
    PassengerClass(passenger_class = 'Second Class'),
    PassengerClass(passenger_class = 'Third Class')
]
session.add_all(rows)
session.commit()

# add data to the survival table
srows = [
    Survival(survived = 'True'),
    Survival(survived = 'False')    
]
session.add_all(srows)
session.commit()

# read in the titanic csv file
titanic_copy = pd.read_csv('titanic.csv')

# change the ids in the csv from 0 - died, 1 - survived to 1 - survived and 2 - died to be consistent with primary keys in survival table
titanic_copy["Survived"] = np.where(titanic_copy["Survived"] == 0, 2, 1)

# add data from csv to the cabin table
data2 = titanic_copy.iloc[:-1].values.tolist()

for row in data2:
    if not type(row[10]) == float:
        brows = Cabin(**{'cabin_name':row[10]})
        session.add(brows)
    
session.commit()

# get unique values from the embark column
data = titanic_copy.Embarked.unique()
data3 = data.tolist()

# add data from csv to the embark table
for row in data3:
    srows = Embarked(**{'port_of_embarkation':row[0]})
    session.add(srows)
    
session.commit()

# add data to the passenger table
for row in data2:
    arows = Passenger(**{
        'name':row[3],
        'sex':row[4],
        'age':row[5],
        'sibsp':row[6],
        'parch':row[7],
        'survival_id':row[1]            
                      })
    session.add(arows)
    
session.commit()