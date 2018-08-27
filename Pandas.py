SELECT 'ФИО: Мизинов Дмитрий Львович';

import os
import psycopg2
import psycopg2.extensions
import logging

logger.info("Создаём подключёние к Postgres")
params = {
    "host": os.environ['APP_POSTGRES_HOST'],
    "port": os.environ['APP_POSTGRES_PORT'],
    "user": 'postgres'
}
conn = psycopg2.connect(**params)


import pandas as pd
import numpy as np


usf = pd.read_csv('/data/Data_pd/Users_p.csv', sep=',', header='infer')
lsf = pd.read_csv('/data/Data_pd/links_p.csv', sep=',', header='infer')
csf = pd.read_csv('/data/Data_pd/Cards_p.csv', sep=',', header='infer')
tsf = pd.read_csv('/data/Data_pd/Location_p.csv', sep=',', header='infer')
ssf = pd.read_csv('/data/Data_pd/Sex_p.csv', sep=',', header='infer')
ksf = pd.read_csv('/data/Data_pd/Channel_p.csv', sep=',', header='infer')
qsf = pd.read_csv('/data/Data_pd/Cardstyps_p.csv', sep=',', header='infer')
osf = pd.read_csv('/data/Data_pd/Opername_p.csv', sep=',', header='infer')

# Вывести по убыванию средний чек операции «Payment» в топ 10 городах и имена городов, где возраст пользователя меньше 25 лет.r11=c[usf['Age']<25][['ID']]
r111=r11[['ID']]
t11=r111.merge(csf, how='inner', left_on='ID', right_on='Userid')
t111= t11[['Cardid']]
l11=t111.merge(lsf, how='inner', left_on='Cardid', right_on='CardID')
l111=l11.merge(osf, how='inner', left_on='OpernameID', right_on='ID')
i11=l111[l111['OperationName']== 'Payment']
i11.groupby('LocationID').agg({'Summ': np.mean}).sort_values(['Summ'], ascending=False).head(10)

# Запрос1 агрегированный. Вывести по убыванию средний чек операции «Payment» в топ 10 городах и имена городов, где возраст пользователя меньше 25 лет.r11=c[usf['Age']<25][['ID']]
r11=((((usf[usf['Age']<25][['ID']]). merge(csf, how='inner', left_on='ID', right_on='Userid')[['Cardid']]).merge(lsf, how='inner', left_on='Cardid', right_on='CardID')).merge(osf, how='inner', left_on='OpernameID', right_on='ID'))
i11=r11[r11['OperationName']== 'Payment']
i11.groupby('LocationID').agg({'Summ': np.mean}).sort_values(['Summ'], ascending=False).head(10)
# 2.Вывести 10 пользователей с максимальным кол-вом карт.
a11= usf.merge(csf, how='inner', left_on='ID', right_on='Userid')
a11.groupby('Userid').agg({'Cardid': np.size}).sort_values(['Cardid'], ascending=False).head(10)
#3 Вывести кол-во транзакций и среднюю сумму транзакции по типам операции
lsf.groupby('OpernameID').agg({'CardID':np.size,'Summ':np.mean}).sort_values(['CardID'],ascending=False).head(10)
# 4Вывести топ городов где пользователи предпочитают совершать операции по кредитным картам. Кол-во операций по кредиткам.
a11=((csf[['Cardid']][['Cardid']][ csf['typcardid']== 2]). merge(lsf, how='inner', left_on='Cardid', right_on='CardID').groupby('LocationID').agg({'Cardid':np.size}).sort_values(['Cardid'],ascending=False).head(10)).merge(tsf, how='inner', left_on='LocationID', right_on='ID')
a22=a11[['Location','Cardid']]

# Вывести топ 10 пользователей с самым высоким оборотом
a11= ((usf.merge(csf, how='inner', left_on='ID', right_on='Userid')[['Userid','Cardid']]).merge(lsf, how='inner',left_on='Cardid',right_on='CardID')).groupby('Userid').agg({'Summ':np.sum}).sort_values(['Summ'],ascending=False).head(10)
#создание файла
agg_filename = '/home/ework.csv'
#выгрузка в файл
a11.to_csv('ework.csv', sep=',')
