```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline
```

### Gather data by reading the titanic csv file into this notebook


```python
titanic_df = pd.read_csv("tested.csv")
titanic_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>PassengerId</th>
      <th>Survived</th>
      <th>Pclass</th>
      <th>Name</th>
      <th>Sex</th>
      <th>Age</th>
      <th>SibSp</th>
      <th>Parch</th>
      <th>Ticket</th>
      <th>Fare</th>
      <th>Cabin</th>
      <th>Embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>892</td>
      <td>0</td>
      <td>3</td>
      <td>Kelly, Mr. James</td>
      <td>male</td>
      <td>34.5</td>
      <td>0</td>
      <td>0</td>
      <td>330911</td>
      <td>7.8292</td>
      <td>NaN</td>
      <td>Q</td>
    </tr>
    <tr>
      <th>1</th>
      <td>893</td>
      <td>1</td>
      <td>3</td>
      <td>Wilkes, Mrs. James (Ellen Needs)</td>
      <td>female</td>
      <td>47.0</td>
      <td>1</td>
      <td>0</td>
      <td>363272</td>
      <td>7.0000</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>2</th>
      <td>894</td>
      <td>0</td>
      <td>2</td>
      <td>Myles, Mr. Thomas Francis</td>
      <td>male</td>
      <td>62.0</td>
      <td>0</td>
      <td>0</td>
      <td>240276</td>
      <td>9.6875</td>
      <td>NaN</td>
      <td>Q</td>
    </tr>
    <tr>
      <th>3</th>
      <td>895</td>
      <td>0</td>
      <td>3</td>
      <td>Wirz, Mr. Albert</td>
      <td>male</td>
      <td>27.0</td>
      <td>0</td>
      <td>0</td>
      <td>315154</td>
      <td>8.6625</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>4</th>
      <td>896</td>
      <td>1</td>
      <td>3</td>
      <td>Hirvonen, Mrs. Alexander (Helga E Lindqvist)</td>
      <td>female</td>
      <td>22.0</td>
      <td>1</td>
      <td>1</td>
      <td>3101298</td>
      <td>12.2875</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
  </tbody>
</table>
</div>



### Assess data to identify areas for data wrangling
Visual and programmatic assessment is done at this stage to come up with candidates for wrangling


```python
titanic_df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 418 entries, 0 to 417
    Data columns (total 12 columns):
     #   Column       Non-Null Count  Dtype  
    ---  ------       --------------  -----  
     0   PassengerId  418 non-null    int64  
     1   Survived     418 non-null    int64  
     2   Pclass       418 non-null    int64  
     3   Name         418 non-null    object 
     4   Sex          418 non-null    object 
     5   Age          332 non-null    float64
     6   SibSp        418 non-null    int64  
     7   Parch        418 non-null    int64  
     8   Ticket       418 non-null    object 
     9   Fare         417 non-null    float64
     10  Cabin        91 non-null     object 
     11  Embarked     418 non-null    object 
    dtypes: float64(2), int64(5), object(5)
    memory usage: 39.3+ KB
    


```python
titanic_df.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>PassengerId</th>
      <th>Survived</th>
      <th>Pclass</th>
      <th>Age</th>
      <th>SibSp</th>
      <th>Parch</th>
      <th>Fare</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>418.000000</td>
      <td>418.000000</td>
      <td>418.000000</td>
      <td>332.000000</td>
      <td>418.000000</td>
      <td>418.000000</td>
      <td>417.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1100.500000</td>
      <td>0.363636</td>
      <td>2.265550</td>
      <td>30.272590</td>
      <td>0.447368</td>
      <td>0.392344</td>
      <td>35.627188</td>
    </tr>
    <tr>
      <th>std</th>
      <td>120.810458</td>
      <td>0.481622</td>
      <td>0.841838</td>
      <td>14.181209</td>
      <td>0.896760</td>
      <td>0.981429</td>
      <td>55.907576</td>
    </tr>
    <tr>
      <th>min</th>
      <td>892.000000</td>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>0.170000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>996.250000</td>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>21.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>7.895800</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1100.500000</td>
      <td>0.000000</td>
      <td>3.000000</td>
      <td>27.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>14.454200</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1204.750000</td>
      <td>1.000000</td>
      <td>3.000000</td>
      <td>39.000000</td>
      <td>1.000000</td>
      <td>0.000000</td>
      <td>31.500000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1309.000000</td>
      <td>1.000000</td>
      <td>3.000000</td>
      <td>76.000000</td>
      <td>8.000000</td>
      <td>9.000000</td>
      <td>512.329200</td>
    </tr>
  </tbody>
</table>
</div>




```python
titanic_df.Survived.value_counts()
```




    0    266
    1    152
    Name: Survived, dtype: int64




```python
titanic_df.Pclass.value_counts()
```




    3    218
    1    107
    2     93
    Name: Pclass, dtype: int64




```python
titanic_df.Sex.value_counts()
```




    male      266
    female    152
    Name: Sex, dtype: int64




```python
titanic_df.Cabin.value_counts()
```




    B57 B59 B63 B66    3
    C78                2
    A34                2
    C55 C57            2
    C101               2
                      ..
    C51                1
    A18                1
    C39                1
    D22                1
    F33                1
    Name: Cabin, Length: 76, dtype: int64




```python
titanic_df.Embarked.value_counts()
```




    S    270
    C    102
    Q     46
    Name: Embarked, dtype: int64




```python
titanic_df.sample(15)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>PassengerId</th>
      <th>Survived</th>
      <th>Pclass</th>
      <th>Name</th>
      <th>Sex</th>
      <th>Age</th>
      <th>SibSp</th>
      <th>Parch</th>
      <th>Ticket</th>
      <th>Fare</th>
      <th>Cabin</th>
      <th>Embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>174</th>
      <td>1066</td>
      <td>0</td>
      <td>3</td>
      <td>Asplund, Mr. Carl Oscar Vilhelm Gustafsson</td>
      <td>male</td>
      <td>40.0</td>
      <td>1</td>
      <td>5</td>
      <td>347077</td>
      <td>31.3875</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>363</th>
      <td>1255</td>
      <td>0</td>
      <td>3</td>
      <td>Strilic, Mr. Ivan</td>
      <td>male</td>
      <td>27.0</td>
      <td>0</td>
      <td>0</td>
      <td>315083</td>
      <td>8.6625</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>109</th>
      <td>1001</td>
      <td>0</td>
      <td>2</td>
      <td>Swane, Mr. George</td>
      <td>male</td>
      <td>18.5</td>
      <td>0</td>
      <td>0</td>
      <td>248734</td>
      <td>13.0000</td>
      <td>F</td>
      <td>S</td>
    </tr>
    <tr>
      <th>10</th>
      <td>902</td>
      <td>0</td>
      <td>3</td>
      <td>Ilieff, Mr. Ylio</td>
      <td>male</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>349220</td>
      <td>7.8958</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>194</th>
      <td>1086</td>
      <td>0</td>
      <td>2</td>
      <td>Drew, Master. Marshall Brines</td>
      <td>male</td>
      <td>8.0</td>
      <td>0</td>
      <td>2</td>
      <td>28220</td>
      <td>32.5000</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>231</th>
      <td>1123</td>
      <td>1</td>
      <td>1</td>
      <td>Willard, Miss. Constance</td>
      <td>female</td>
      <td>21.0</td>
      <td>0</td>
      <td>0</td>
      <td>113795</td>
      <td>26.5500</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>341</th>
      <td>1233</td>
      <td>0</td>
      <td>3</td>
      <td>Lundstrom, Mr. Thure Edvin</td>
      <td>male</td>
      <td>32.0</td>
      <td>0</td>
      <td>0</td>
      <td>350403</td>
      <td>7.5792</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>255</th>
      <td>1147</td>
      <td>0</td>
      <td>3</td>
      <td>MacKay, Mr. George William</td>
      <td>male</td>
      <td>NaN</td>
      <td>0</td>
      <td>0</td>
      <td>C.A. 42795</td>
      <td>7.5500</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>217</th>
      <td>1109</td>
      <td>0</td>
      <td>1</td>
      <td>Wick, Mr. George Dennick</td>
      <td>male</td>
      <td>57.0</td>
      <td>1</td>
      <td>1</td>
      <td>36928</td>
      <td>164.8667</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>112</th>
      <td>1004</td>
      <td>1</td>
      <td>1</td>
      <td>Evans, Miss. Edith Corse</td>
      <td>female</td>
      <td>36.0</td>
      <td>0</td>
      <td>0</td>
      <td>PC 17531</td>
      <td>31.6792</td>
      <td>A29</td>
      <td>C</td>
    </tr>
    <tr>
      <th>319</th>
      <td>1211</td>
      <td>0</td>
      <td>2</td>
      <td>Jefferys, Mr. Ernest Wilfred</td>
      <td>male</td>
      <td>22.0</td>
      <td>2</td>
      <td>0</td>
      <td>C.A. 31029</td>
      <td>31.5000</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>393</th>
      <td>1285</td>
      <td>0</td>
      <td>2</td>
      <td>Gilbert, Mr. William</td>
      <td>male</td>
      <td>47.0</td>
      <td>0</td>
      <td>0</td>
      <td>C.A. 30769</td>
      <td>10.5000</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>283</th>
      <td>1175</td>
      <td>1</td>
      <td>3</td>
      <td>Touma, Miss. Maria Youssef</td>
      <td>female</td>
      <td>9.0</td>
      <td>1</td>
      <td>1</td>
      <td>2650</td>
      <td>15.2458</td>
      <td>NaN</td>
      <td>C</td>
    </tr>
    <tr>
      <th>240</th>
      <td>1132</td>
      <td>1</td>
      <td>1</td>
      <td>Lindstrom, Mrs. Carl Johan (Sigrid Posse)</td>
      <td>female</td>
      <td>55.0</td>
      <td>0</td>
      <td>0</td>
      <td>112377</td>
      <td>27.7208</td>
      <td>NaN</td>
      <td>C</td>
    </tr>
    <tr>
      <th>27</th>
      <td>919</td>
      <td>0</td>
      <td>3</td>
      <td>Daher, Mr. Shedid</td>
      <td>male</td>
      <td>22.5</td>
      <td>0</td>
      <td>0</td>
      <td>2698</td>
      <td>7.2250</td>
      <td>NaN</td>
      <td>C</td>
    </tr>
  </tbody>
</table>
</div>



#### Issues to clean
- Missing data
- Incorrect data types for the Sex,Embarked, Cabin,survived and pclass columns
- change the dataframe headers have the first letter in uppercase

### Clean data 
Here I work on the issues identified in the previous stage. 


```python
# create a copy so as to preserve the original dataset
titanic_df_clean = titanic_df.copy()
```

##### Missing data
There is missing data in the Age, fare and cabin columns. I won't replace these values because doing so will distort the data and affect the conclusions that can be generated from the data. I will ignore these in my analysis and use these columns the way they are.

##### Change dataframe headers to lowercase
I am changing these to make the analysis faster 


```python
titanic_df_clean.columns = map(str.lower, titanic_df.columns)
```


```python
titanic_df_clean.columns
```




    Index(['passengerid', 'survived', 'pclass', 'name', 'sex', 'age', 'sibsp',
           'parch', 'ticket', 'fare', 'cabin', 'embarked'],
          dtype='object')



##### Incorrect datatypes
Change column data types to the right data types. Columns to change: sex,embarked, cabin, pclass, survived


```python
# Categorical 
titanic_df_clean.sex = titanic_df_clean.sex.astype('category')
titanic_df_clean.embarked = titanic_df_clean.embarked.astype('category')
titanic_df_clean.cabin = titanic_df_clean.cabin.astype('category')
titanic_df_clean.survived = titanic_df_clean.survived.astype('category')
titanic_df_clean.pclass = titanic_df_clean.pclass.astype('category')
```


```python
titanic_df_clean.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 418 entries, 0 to 417
    Data columns (total 12 columns):
     #   Column       Non-Null Count  Dtype   
    ---  ------       --------------  -----   
     0   passengerid  418 non-null    int64   
     1   survived     418 non-null    category
     2   pclass       418 non-null    category
     3   name         418 non-null    object  
     4   sex          418 non-null    category
     5   age          332 non-null    float64 
     6   sibsp        418 non-null    int64   
     7   parch        418 non-null    int64   
     8   ticket       418 non-null    object  
     9   fare         417 non-null    float64 
     10  cabin        91 non-null     category
     11  embarked     418 non-null    category
    dtypes: category(5), float64(2), int64(3), object(2)
    memory usage: 28.2+ KB
    

### Analyzing and Visualizing data


```python
# total passengers that boarded the titanic
titanic_df_clean.passengerid.count()
```




    418




```python
# passengers that survived the shipwreck
titanic_df_clean[titanic_df_clean['survived'] == 1].survived.count()
```




    152




```python
# list of all survivors with their names,age and sex
titanic_df_clean[titanic_df_clean['survived'] == 1].loc[:,['name','age','sex']]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>age</th>
      <th>sex</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>Wilkes, Mrs. James (Ellen Needs)</td>
      <td>47.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Hirvonen, Mrs. Alexander (Helga E Lindqvist)</td>
      <td>22.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Connolly, Miss. Kate</td>
      <td>30.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Abrahim, Mrs. Joseph (Sophie Halaut Easu)</td>
      <td>18.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>12</th>
      <td>Snyder, Mrs. John Pillsbury (Nelle Stevenson)</td>
      <td>23.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>409</th>
      <td>Peacock, Miss. Treasteall</td>
      <td>3.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>410</th>
      <td>Naughton, Miss. Hannah</td>
      <td>NaN</td>
      <td>female</td>
    </tr>
    <tr>
      <th>411</th>
      <td>Minahan, Mrs. William Edward (Lillian E Thorpe)</td>
      <td>37.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>412</th>
      <td>Henriksson, Miss. Jenny Lovisa</td>
      <td>28.0</td>
      <td>female</td>
    </tr>
    <tr>
      <th>414</th>
      <td>Oliva y Ocana, Dona. Fermina</td>
      <td>39.0</td>
      <td>female</td>
    </tr>
  </tbody>
</table>
<p>152 rows × 3 columns</p>
</div>




```python
# total passengers by class
class_distribution = titanic_df_clean.groupby('pclass').survived.count()
class_distribution
```




    pclass
    1    107
    2     93
    3    218
    Name: survived, dtype: int64




```python
# survival rate by passenger class
distribution_pclass_survival = titanic_df_clean.groupby(['survived','pclass']).size()
distribution_pclass_survival
```




    survived  pclass
    0         1          57
              2          63
              3         146
    1         1          50
              2          30
              3          72
    dtype: int64




```python
# survival rate by sex
titanic_df_clean.groupby(['survived','sex']).size()
```




    survived  sex   
    0         female      0
              male      266
    1         female    152
              male        0
    dtype: int64




```python
# where did most people board from?
titanic_df_clean.groupby('embarked').survived.count()
```




    embarked
    C    102
    Q     46
    S    270
    Name: survived, dtype: int64




```python
# average fare by class
titanic_df_clean.groupby('pclass').fare.mean()
```




    pclass
    1    94.280297
    2    22.202104
    3    12.459678
    Name: fare, dtype: float64




```python
# did people share cabins? Which cabin had the most people and how many were they?
titanic_df_clean.groupby('cabin').survived.count().sort_values(ascending=False)
```




    cabin
    B57 B59 B63 B66    3
    C6                 2
    B45                2
    C78                2
    C89                2
                      ..
    C51                1
    C53                1
    C54                1
    A18                1
    G6                 1
    Name: survived, Length: 76, dtype: int64




```python
# which cabins belonged to which passenger class and whats the distribution
titanic_df_clean.groupby('pclass').cabin.count().sort_values(ascending=False)
```




    pclass
    1    80
    2     7
    3     4
    Name: cabin, dtype: int64




```python
# correlation between port of embarkation and passenger_class
titanic_df_clean.groupby(['embarked','pclass']).size()
```




    embarked  pclass
    C         1          56
              2          11
              3          35
    Q         1           1
              2           4
              3          41
    S         1          50
              2          78
              3         142
    dtype: int64



#### Insights
1. 418 passengers boarded the titanic
2. All the female aboard the titanic survived and all the men died
3. The youngest person was less than a year old and the oldest was 76 years old
4. 152 passengers survived and they were all women
5. The biggest number of passengers aboard the ship were in third class with a total of 218, followed by first class at 107 and second class at 93
6. Southampton port had the most passengers boarding the ship with 270 passengers boarding at that port, 102 from Cherbourg port and 46 from Queenstown
7. Even though first class had the second highest number of passengers, they got the most cabins with 80 of the 92 cabins being taken by the passengers in first class. Most of the second and third class passengers in this dataset were not assigned cabins.

### Visualizations


```python
# chart displaying distribution of passengers by pclass
locations = [1,2,3]
heights = class_distribution

labels = ['first class','second class','third class']
plt.bar(locations,heights,tick_label=labels)
plt.title('Distribution of passengers by class')
plt.xlabel('passenger classes')
plt.ylabel('Total number of passengers')
plt.show()
```


    
![png](output_36_0.png)
    

