SELECT '���: ������� ������� �������';

-------------------------------------------------------------1------------------------------------------------------------
---------������� �� �������� ������� ��� �������� �Payment� � ��� 10 ������� � ����� �������, ��� ������� ������������ ������ 25 ���.

With aaa as (select id from users_p where age<25 limit 3), bbb as (select id from cards_p where userid in (select * from aaa)),ccc as (select locationid, avg(summ) as avg from links_p where cardid in (select * from bbb) and opernameid in (select id from opername_p where OperationName='Payment') group by locationid) select location,avg from location_p inner join ccc on (location_p.id=ccc.locationid) order by avg DESC;
-------------------------------------------------------------2------------------------------------------------------------
---------������� 10 ������������� � ������������ ���-��� ����.

Select users_p.id,count(cards_p.id) as countt from users_p inner join cards_p on (users_p.id= cards_p.userid) group by users_p.id order by countt DESC limit 10;
-------------------------------------------------------------3-----------------------------------------------------------------------������� ��� 10 ������������� c ���������� ������� ����� �������� �Transfer� � ���� ����� ����������� �� ��������� � ������ ���������� ����������

With aaa as (select users_p.id, users_p.locationid, cards_p.id as card from users_p inner join cards_p on (users_p.id= cards_p.userid)) select aaa.id, avg(summ) from aaa inner join links_p on (aaa.card=links_p.cardid) where aaa.locationid<>links_p.locationid and opernameid in (select id from opername_p where OperationName='Transfer')  group by aaa.id order by avg(summ) DESC  limit 10;
-------------------------------------------------------------4------------------------------------------------------------
--------������� ������ ���� ���������� �������� � �������� �������� � ������������ ������ ��������

With mmm as (Select cardid,channelid, opernameid, summ,max(summ) over (partition by opernameid ) as maxx from links_p),ttt as  (select channelid, opernameid, avg(maxx) as maxsumm from mmm where summ=maxx group by channelid, opernameid), ppp as  (select channelid, operationname, maxsumm from ttt inner join opername_p on (ttt.opernameid=opername_p.id)) select channel, operationname,maxsumm from ppp inner join channel_p on (ppp.channelid= channel_p.id) order by channel, operationname ; 
-------------------------------------------------------------5------------------------------------------------------------
------------������� ��� ������������� � ���������� ���������� � ������� ���� ���������� � ������ �������.

With bbb as (Select users_p.id as idname, users_p.locationid as locationname,cards_p.id as cc from users_p inner join cards_p on (users_p.id=cards_p.userid) ) select bbb.idname, count(links_p.id)  from bbb inner join links_p on  (bbb.cc=links_p.cardid) where bbb.locationname<>locationid group by bbb.idname order by count(links_p.id)  desc limit 10;
-------------------------------------------------------------6------------------------------------------------------------
---------������� ��� ������� ��� ������������ ������������ ��������� �������� �� ��������� ������. ���-�� �������� �� ���������.

Select locationid, count(id) from links_p where cardid in (Select id from cards_p where typcardid=2) group by locationid order by count(id) desc limit 10;

-------------------------------------------------------------7------------------------------------------------------------
----------������� ��� �������, ��� ������� ��� �� �������� �Output� ���� �������� �� ������ �� 1%. (������ ������� ���� ��� ������� ������. � �������� ����� ��������������� ����� ������������ ����������)

With bbb as (select id from opername_p where OperationName='Output') ,r1 as (Select avg(summ)*1.01 as t1  from links_p where opernameid in (select * from bbb)  group by opernameid), qq as(Select locationid,avg(summ) as r2 from links_p where opernameid in (select * from bbb)  group by locationid) select r2 from qq cross join r1 where r2>t1;
-------------------------------------------------------------8------------------------------------------------------------
-----------������� �����, ��� ������� ���������� �������� �Output� ����������� � vsp � US ������������.

With g1 as (select id from opername_p where OperationName='Output'), g2 as (select id from Channel_p where Channel='VSP'), g3 as (select id from Channel_p where Channel='US'),  aaa as (Select locationid, count(id) as c1 from links_p where opernameid in (select * from g1) and channelid in (select * from g2) group by locationid), bbb as (Select locationid, count(id) as c2 from links_p  where opernameid in (select * from g1) and channelid in (select * from g3)  group by locationid), ttt as (select aaa.locationid as l1,aaa.c1,bbb.c2 from aaa inner join bbb on (aaa.locationid=bbb.locationid)),rez as (select l1 from ttt order by (c1+c2) desc limit 1) select location from location_p where id in (select * from rez);
-------------------------------------------------------------9------------------------------------------------------------
-------������� ���-�� ���������� � ������� ����� ���������� �� ����� ��������
Select operationname, count(links_p.id), avg(summ) from links_p inner join opername_p on (links_p.opernameid= opername_p.id) group by operationname order by count(links_p.id) desc ;
-------------------------------------------------------------10-----------------------------------------------------------
---------������� ��� 10 ������������� � ����� ������� ��������.

With T2 as (Select cardid, sum(summ) as ss from links_p group by cardid), T1 as (Select users_p.id as us, cards_p.id as ca from users_p inner join cards_p on (users_p.id=cards_p.userid)) select us, ss from t1 inner join t2 on (t1.ca=t2.cardid) order by ss desc limit 10;
