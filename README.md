# ERP

## 平台简介

为外贸企业定制开发的小型ERP系统

实现订单一单到底管理流程：
- 开发客户、
- 维系客户、
- 下单（销售订单）、
- 生产计划、
- 客户分期打款、
- 领导审批、
- 产生生产订单下发生产部门、
- 装箱发货并记录每一件货物与集装箱对应关系和各种发货数据、
- 财务为销售员提成、
- 订单结束等。

流程分为三种：
1. 整机销售流程
2. 配件销售流程
3. 维护流程

## 帐号登录

无法登录则：
sys_user表password列 请改为： 6fef297d2d6046cdbd013cf92494f0afc99f963b0ecb759f011a6d31
```
update items_zongjin.sys_user
set password='6fef297d2d6046cdbd013cf92494f0afc99f963b0ecb759f011a6d31'
where 1 = 1
```

##　ｏｐｅｎｄｊｄｋ１1　ｔｏｍｃａｔ９ 无法运行

pom.xml 中增加： 
```
<dependency>
			<groupId>javax.xml.bind</groupId>
			<artifactId>jaxb-api</artifactId>
			<version>2.3.0</version>
		</dependency>
		<dependency>
			<groupId>com.sun.xml.bind</groupId>
			<artifactId>jaxb-impl</artifactId>
			<version>2.3.0</version>
		</dependency>
		<dependency>
			<groupId>com.sun.xml.bind</groupId>
			<artifactId>jaxb-core</artifactId>
			<version>2.3.0</version>
		</dependency>
		<dependency>
			<groupId>javax.activation</groupId>
			<artifactId>activation</artifactId>
			<version>1.1.1</version>
		</dependency>

```