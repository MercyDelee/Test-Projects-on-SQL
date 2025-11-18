#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd

df = pd.read_csv("KMS Sql Case Study.csv", encoding="latin1")

df.head()
df.info()
df.describe()


# In[3]:


df.isnull().sum()


# In[4]:


df[['Sales', 'Profit', 'Order Quantity']].describe()


# In[5]:


df['Sales'].sum()
df['Profit'].sum()


# In[6]:


df.groupby('Region')[['Sales', 'Profit']].sum().sort_values('Sales', ascending=False)


# In[7]:


df.groupby('Product Name')['Profit'].sum().sort_values(ascending=False).head(10)


# In[10]:


import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("KMS Sql Case Study.csv", encoding="latin1")
df['Order Date'] = pd.to_datetime(df['Order Date'])


# In[9]:


plt.figure(figsize=(8,5))
df.groupby('Product Category')['Sales'].sum().plot(kind='bar')
plt.title("Sales by Product Category")
plt.ylabel("Total Sales")
plt.xlabel("Category")
plt.show()


# In[11]:


plt.figure(figsize=(8,5))
df.groupby('Region')['Profit'].sum().plot(kind='bar', color='orange')
plt.title("Profit by Region")
plt.ylabel("Profit")
plt.xlabel("Region")
plt.show()


# In[ ]:




