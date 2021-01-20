# @rmw/web

后端服务器

* redis
* miniio
* rxdb
* web server



const pm2 = require('pm2');

pm2.connect(() => {
  pm2.list(function(err, processes) {
    const fooProcess = processes.find(p => p.name == 'foo');

    pm2.launchBus((err, bus) => {
      bus.on('process:msg', packet => {
        if (packet.startBar === true) {
          pm.start({ script: 'bar.js' }, (err, apps) => { ... })
        }
      });
      bus.on('error', console.error);
    });
  });
});


## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)
