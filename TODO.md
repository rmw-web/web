## 规则设计

贡献8GB存储空间，可以创建一个域名

发布内容，可以主动推送给存储服务器，存储会服务器会要求2倍空间作为报酬

## 用户层级设计

用户身份级别、初始投票权重如下

* 网站管理员 1000 - 信用值
* 股票维护组 100 + 信用值
* 普通使用者 信用值

信用值

* 投票成功（和最终结果一致），+1分。
* 投票失败 (和最终结果不一致），失败扣分

失败扣分理论上扣分等于 总通过/总拒绝 ，最扣分为 1 ，这样假设一个人一直投成功，他不会增加信用，公式如下。

```
拒绝 * 拒绝扣分 + 成功 = 0
```

一个提案投票累计分数达到100分及以上，就通过。

分类参考 [申万行业分类](http://www.swsindex.com/idx0530.aspx)

数据库设计

* page
  * name : id val
  * page : id kind
  * page_name : id name_id
  * page_issue : id page_id issue_id time
  * issue : id action user_id time state li
    li 是一个jsonb数组
  * issue_vote : id issue_id user_id time score
* stock
  * market : id val

    * 深圳交易所
    * 上海交易所
    * 纳斯达克交易所
  * kind : id name up
* com
  * com : id market_id code name page_id\
    股票名程序自动根据CODE去抓取
    没有收录的市场发邮件提醒程序员去写爬虫
