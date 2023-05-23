#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
get_ipython().run_line_magic('matplotlib', 'inline')


# In[2]:


pip install pandas_profiling


# # Importing the libraries

# In[41]:


import numpy as np
import pandas as pd
from pandas_profiling import ProfileReport
import pandas_profiling as pp


# # Load the CSV File

# In[17]:


Stock_data = pd.read_csv(r"D:\work\python\Assignments\python\all_stocks_5yr.csv\all_stocks_5yr.csv")


# In[18]:


Stock_data


# In[19]:


Stock_data.head()


# # Examiming Data

# In[20]:


Stock_data.tail()


# In[9]:


Stock_data.describe()


# In[23]:


Stock_data.shape


# In[24]:


Stock_data.isnull().sum()


# In[25]:


Stock_data.info()


# In[26]:


Stock_data.corr()


# In[28]:


Stock_data['returns'] = Stock_data['close'].pct_change()


# In[29]:


Stock_data.head()


# # Data Profiling

# By pandas profiling, an interactive **HTML report** gets generated which contains all the information about the columns of the dataset, like the counts and type of each column. 
# 
# 1.Detailed information about each column, coorelation between different columns and a sample of dataset
# 
# 2.It gives us visual interpretation of each column in the data
# 
# 3.Spread of the data can be better understood by the distribution plot
# 
# 4.Grannular level analysis of each column.

# In[40]:


profile = pandas_profiling.ProfileReport(Stock_data)


# In[44]:


profile = pp.ProfileReport(Stock_data)
profile.to_file("Stock_data_after_processing.html")


# In[45]:


profile


# In[51]:


Stock_data['Name'].value_counts().head()


# In[81]:


Stock_data.sort_values(by=['Name'],ascending= False).head(10)


# In[52]:


Stock_data['Name'].value_counts()


# In[83]:


Stock_data.groupby('Name')['volume'].count().sort_values(ascending=False)


# In[53]:


Name= Stock_data.groupby('Name')


# In[54]:


Name.get_group('AMD')


# In[60]:


plt.figure(figsize = (10,5))
sns.lineplot(data = Stock_data,x='Name',y='close')
plt.title('Closing Price')
plt.show()


# In[69]:


# Let's analyze some of the stocks.
amzn = Stock_data.loc[Stock_data['Name'] == 'AMZN']
amzn.head()


# We need to make sure if the date column is either a categorical type or a datetype. In our case date is a categorical datatype so we need to change it to datetime.

# In[70]:


amzn.info() # Check whether the date is as object type or date type


# In[71]:


#  Change to dateformat
amzn.head()


# In[72]:


amzn.info()


# In[73]:


# Simple plotting of Amazon Stock Price
# First Subplot
f, (ax1, ax2) = plt.subplots(1, 2, figsize=(14,5))
ax1.plot(amzn["date"], amzn["close"])
ax1.set_xlabel("Date", fontsize=12)
ax1.set_ylabel("Stock Price")
ax1.set_title("Amazon Close Price History")

# Second Subplot
ax1.plot(amzn["date"], amzn["high"], color="green")
ax1.set_xlabel("Date", fontsize=12)
ax1.set_ylabel("Stock Price")
ax1.set_title("Amazon High Price History")

# Third Subplot
ax1.plot(amzn["date"], amzn["low"], color="red")
ax1.set_xlabel("Date", fontsize=12)
ax1.set_ylabel("Stock Price")
ax1.set_title("Amazon Low Price History")

# Fourth Subplot
ax2.plot(amzn["date"], amzn["volume"], color="orange")
ax2.set_xlabel("Date", fontsize=12)
ax2.set_ylabel("Stock Price")
ax2.set_title("Amazon's Volume History")
plt.show()


# In[78]:


plt.figure(figsize = (10,5))
sns.lineplot(data = Stock_data,x='date',y='returns')
plt.title('Return Distribution')
plt.xlabel('Returns')
plt.show()


# In[80]:


Stock_data['volume'].plot(legend = True,figsize=(10,4))


# In[86]:


import seaborn as sns                                              # Provides a high level interface for drawing attractive and informative statistical graphics
sns.set()
plt.subplots(figsize=(10,20))
sns.heatmap(Stock_data.corr(),annot=True)


# In[ ]:




